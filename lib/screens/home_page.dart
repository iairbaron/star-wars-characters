import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/character_controller.dart';
import '../widgets/character_grid.dart';
import '../widgets/error_view.dart';
import '../widgets/pagination_controls.dart';
import 'search_page.dart';

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

  void _openSearchPage() {
    final state = ref.read(characterControllerProvider);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPage(
          allCharacters: state.allCharacters,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterControllerProvider);
    final controller = ref.read(characterControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Characters'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _openSearchPage,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar personaje...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
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
    );
  }
}
