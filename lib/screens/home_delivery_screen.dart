import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../providers/app_state.dart';
import '../data/mock_data.dart';
import '../widgets/zomato_search_bar.dart';
import '../widgets/promo_banner_slider.dart';
import '../widgets/category_carousel.dart';
import '../widgets/filter_chips_bar.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_detail_screen.dart';

class HomeDeliveryScreen extends StatelessWidget {
  final AppState appState;
  final VoidCallback onOpenCart;

  const HomeDeliveryScreen({
    super.key,
    required this.appState,
    required this.onOpenCart,
  });

  @override
  Widget build(BuildContext context) {
    final restaurants = appState.filteredRestaurants;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top App Bar / Location Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppTheme.primaryRed,
                              size: 22,
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Home',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down, size: 18, color: AppTheme.textPrimary),
                                  ],
                                ),
                                Text(
                                  appState.selectedAddress,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textSecondary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Language / Profile quick action
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: AppTheme.borderLight),
                          ),
                          child: const Icon(
                            Icons.language,
                            size: 18,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Search Bar with Veg switch
                SliverToBoxAdapter(
                  child: ZomatoSearchBar(
                    onChanged: (query) => appState.setSearchQuery(query),
                    isVegOnly: appState.isVegOnly,
                    onToggleVeg: () => appState.toggleVegMode(),
                  ),
                ),

                // Promotional Banner Slider ("Explore now >")
                const SliverToBoxAdapter(
                  child: PromoBannerSlider(),
                ),

                // Food Category Circular Icons
                SliverToBoxAdapter(
                  child: CategoryCarousel(
                    onSelectCategory: (category) {
                      appState.setSearchQuery(category);
                    },
                  ),
                ),

                // Filter Chips Bar
                SliverToBoxAdapter(
                  child: FilterChipsBar(
                    selectedFilter: appState.selectedFilter,
                    onFilterSelected: (filter) => appState.setSelectedFilter(filter),
                  ),
                ),

                // Section Header: RECOMMENDED FOR YOU
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                    child: Text(
                      'RECOMMENDED FOR YOU',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary.withOpacity(0.8),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                // 2-Column Restaurant Cards Grid
                if (restaurants.isEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'No restaurants found',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Try turning off the Pure Veg filter or searching something else',
                            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.74,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final restaurant = restaurants[index];
                          return RestaurantCard(
                            restaurant: restaurant,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RestaurantDetailScreen(
                                    restaurant: restaurant,
                                    appState: appState,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: restaurants.length,
                      ),
                    ),
                  ),

                // Section Header: EXPLORE MORE
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 10),
                    child: Text(
                      'EXPLORE MORE',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary.withOpacity(0.8),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                // EXPLORE MORE Horizontal Cards
                SliverToBoxAdapter(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 80),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: MockData.exploreMoreItems.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = MockData.exploreMoreItems[index];
                        return Container(
                          width: 150,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.borderLight),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item['icon'] == 'train'
                                    ? Icons.train
                                    : item['icon'] == 'calendar'
                                        ? Icons.calendar_today
                                        : Icons.local_offer,
                                color: Color(item['color'] as int),
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                item['subtitle'] as String,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Floating Green Action Button (as seen in bottom right of home page.jpeg)
            Positioned(
              right: 16,
              bottom: appState.totalItemCount > 0 ? 80 : 20,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2C5E3B),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),

            // Sticky Bottom Cart Bar
            if (appState.totalItemCount > 0)
              Positioned(
                left: 16,
                right: 16,
                bottom: 12,
                child: GestureDetector(
                  onTap: onOpenCart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.nearFastGreen,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.nearFastGreen.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${appState.totalItemCount} ${appState.totalItemCount == 1 ? "ITEM" : "ITEMS"}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '₹${appState.grandTotal.toStringAsFixed(0)} plus taxes',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'View Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_right, color: Colors.white, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
