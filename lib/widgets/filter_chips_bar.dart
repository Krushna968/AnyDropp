import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FilterChipsBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String filter) onFilterSelected;

  const FilterChipsBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'label': 'Filters', 'icon': Icons.tune, 'isDropdown': true},
      {'label': 'Near & Fast', 'icon': Icons.flash_on, 'color': AppTheme.nearFastGreen},
      {'label': 'No packaging', 'icon': null},
      {'label': 'Rating 4.0+', 'icon': Icons.star_rounded, 'color': Colors.amber.shade700},
      {'label': 'Pure Veg', 'icon': Icons.eco, 'color': AppTheme.vegGreen},
    ];

    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final label = filter['label'] as String;
          final isSelected = selectedFilter == label;
          final iconData = filter['icon'] as IconData?;
          final iconColor = (filter['color'] as Color?) ?? AppTheme.textPrimary;
          final isDropdown = filter['isDropdown'] == true;

          return GestureDetector(
            onTap: () => onFilterSelected(label),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryRed.withOpacity(0.08) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryRed : AppTheme.borderLight,
                  width: isSelected ? 1.2 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconData != null) ...[
                    Icon(
                      iconData,
                      size: 15,
                      color: isSelected ? AppTheme.primaryRed : iconColor,
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppTheme.primaryRed : AppTheme.textPrimary,
                    ),
                  ),
                  if (isDropdown) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                      color: AppTheme.textPrimary,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
