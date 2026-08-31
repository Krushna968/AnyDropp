import 'food_item.dart';

class CartItem {
  final FoodItem foodItem;
  final String restaurantName;
  int quantity;

  CartItem({
    required this.foodItem,
    required this.restaurantName,
    this.quantity = 1,
  });

  double get total => foodItem.price * quantity;
}
