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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filtrar:', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
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
                        ),
                      ),
                    ],
                  ),
                  onSelected: (_) => controller.toggleFavoriteFilter(),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  checkmarkColor: Colors.white,
                ),
                const SizedBox(width: 8),
                ...state.availableGenders.map((gender) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    selected: state.selectedGender == gender,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: state.selectedGender == gender 
                              ? Colors.white 
                              : Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          gender,
                          style: TextStyle(
                            color: state.selectedGender == gender 
                                ? Colors.white 
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onSelected: (_) {
                      controller.setGenderFilter(
                        state.selectedGender == gender ? null : gender
                      );
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    checkmarkColor: Colors.white,
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 