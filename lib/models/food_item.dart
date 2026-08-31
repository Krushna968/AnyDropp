class FoodItem {
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final double? originalPrice;
  final String description;
  final String imageUrl;
  final bool isVeg;
  final double rating;
  final int ratingCount;
  final String category;
  final bool isBestseller;

  const FoodItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.imageUrl,
    required this.isVeg,
    this.rating = 4.3,
    this.ratingCount = 120,
    required this.category,
    this.isBestseller = false,
  });
}
