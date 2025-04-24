import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/character_controller.dart';
import '../widgets/character_grid.dart';
import '../widgets/error_view.dart';
import '../widgets/pagination_controls.dart';
import '../widgets/search_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Cargar los personajes cuando se inicia la página
    Future.microtask(() => ref.read(characterControllerProvider.notifier).loadCharacters());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterControllerProvider);
    final controller = ref.read(characterControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Characters'),
        bottom: CharacterSearchBar(onSearch: controller.search),
      ),
      body: state.error != null
          ? ErrorView(
              error: state.error!,
              onRetry: () => controller.loadCharacters(),
            )
          : Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.displayedCharacters.isEmpty
                          ? const Center(
                              child: Text('No hay personajes disponibles'))
                          : CharacterGrid(
                              characters: state.displayedCharacters,
                            ),
                ),
                if (!state.isLoading && state.displayedCharacters.isNotEmpty)
                  PaginationControls(
                    currentPage: state.currentPage,
                    totalPages: state.totalPages,
                    hasNextPage: state.hasNextPage,
                    hasPreviousPage: state.hasPreviousPage,
                    onNextPage: () => controller.nextPage(),
                    onPreviousPage: () => controller.previousPage(),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.loadCharacters(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
