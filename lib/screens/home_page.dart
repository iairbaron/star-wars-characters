import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/character_controller.dart';
import '../widgets/character_grid.dart';
import '../widgets/error_view.dart';
import '../widgets/pagination_controls.dart';
import '../widgets/filter_bar.dart';
import 'search_page.dart';
import '../widgets/home_app_bar.dart';

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
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SearchPage(
          allCharacters: state.allCharacters,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.05);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterControllerProvider);
    final controller = ref.read(characterControllerProvider.notifier);

    return Scaffold(
      appBar: HomeAppBar(onSearchTap: _openSearchPage),
      body: state.error != null
          ? ErrorView(
              error: state.error!,
              onRetry: () => controller.loadCharacters(),
            )
          : Column(
              children: [
                const FilterBar(),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.displayedCharacters.isEmpty
                          ? Center(
                              child: Text(
                                state.showOnlyFavorites
                                    ? 'No hay personajes favoritos'
                                    : 'No hay personajes disponibles',
                              ),
                            )
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
