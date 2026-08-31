import 'food_item.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String deliveryTime; // e.g. "25-30 mins"
  final String distance; // e.g. "1.8 km"
  final String discountTag; // e.g. "50% OFF select items"
  final bool isNearAndFast;
  final bool isPureVeg;
  final String cuisine;
  final double minOrderValue;
  final List<FoodItem> menu;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    this.reviewCount = 500,
    required this.deliveryTime,
    required this.distance,
    required this.discountTag,
    this.isNearAndFast = true,
    this.isPureVeg = false,
    required this.cuisine,
    this.minOrderValue = 149.0,
    this.menu = const [],
  });
}
