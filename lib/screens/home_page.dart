import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/character_controller.dart';
import '../models/character.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterControllerProvider);
    final controller = ref.read(characterControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Characters'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar personaje...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.search,
            ),
          ),
        ),
      ),
      body: state.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    state.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.loadCharacters(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.displayedCharacters.isEmpty
                          ? const Center(
                              child: Text('No hay personajes disponibles'))
                          : ListView.builder(
                              itemCount: state.displayedCharacters.length,
                              itemBuilder: (context, index) {
                                final character = state.displayedCharacters[index];
                                return CharacterTile(character: character);
                              },
                            ),
                ),
                if (!state.isLoading && state.displayedCharacters.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: state.hasPreviousPage
                              ? () => controller.previousPage()
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Página ${state.currentPage} de ${state.totalPages}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: state.hasNextPage
                              ? () => controller.nextPage()
                              : null,
                        ),
                      ],
                    ),
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

class CharacterTile extends StatelessWidget {
  final Character character;

  const CharacterTile({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        character.image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
      ),
      title: Text(character.name),
      subtitle: Text(character.gender),
    );
  }
}
