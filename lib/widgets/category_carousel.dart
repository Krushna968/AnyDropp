import 'package:flutter/material.dart';
import 'zomato_network_image.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class CategoryCarousel extends StatelessWidget {
  final Function(String category) onSelectCategory;

  const CategoryCarousel({
    super.key,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: MockData.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = MockData.categories[index];
          return GestureDetector(
            onTap: () => onSelectCategory(item['name']!),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppTheme.borderLight, width: 0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: ZomatoNetworkImage(
                      imageUrl: item['imageUrl']!,
                      fit: BoxFit.cover,
                      width: 58,
                      height: 58,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
