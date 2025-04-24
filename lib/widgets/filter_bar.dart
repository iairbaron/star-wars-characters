import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/character_controller.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterControllerProvider);
    final controller = ref.read(characterControllerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filtrar:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              FilterChip(
                selected: state.showOnlyFavorites,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 18,
                      color: state.showOnlyFavorites ? Colors.white : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Favoritos',
                      style: TextStyle(
                        color: state.showOnlyFavorites ? Colors.white : Colors.black,
                        fontWeight: state.showOnlyFavorites
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                onSelected: (_) => controller.toggleFavoriteFilter(),
                selectedColor: Theme.of(context).colorScheme.primary,
                checkmarkColor: Colors.white,
                elevation: state.showOnlyFavorites ? 3 : 0,
                pressElevation: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
} 