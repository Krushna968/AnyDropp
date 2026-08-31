import 'dart:async';
import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../models/restaurant.dart';
import '../models/order_model.dart';
import '../data/mock_data.dart';

class AppState extends ChangeNotifier {
  bool _isVegOnly = false;
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedAddress = 'Home - HSR Layout, Sector 2, Bengaluru';
  
  final Map<String, CartItem> _cart = {};
  OrderModel? _currentOrder;
  Timer? _orderTrackerTimer;

  bool get isVegOnly => _isVegOnly;
  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;
  String get selectedAddress => _selectedAddress;
  List<CartItem> get cartItems => _cart.values.toList();
  OrderModel? get currentOrder => _currentOrder;

  int get totalItemCount => _cart.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _cart.values.fold(0.0, (sum, item) => sum + item.total);

  // Group items by restaurant to support Anydrop Multi-Store Smart Cart
  Map<String, List<CartItem>> get itemsByStore {
    final Map<String, List<CartItem>> map = {};
    for (var item in _cart.values) {
      map.putIfAbsent(item.restaurantName, () => []).add(item);
    }
    return map;
  }

  int get storeCount => itemsByStore.keys.length;

  double get deliveryFee {
    if (_cart.isEmpty) return 0.0;
    // Base fee + slight increment per extra store as described in multi-store logic
    return 25.0 + ((storeCount - 1) * 15.0);
  }

  double get platformFee => _cart.isEmpty ? 0.0 : 6.0;

  double get taxesAndCharges => _cart.isEmpty ? 0.0 : (subtotal * 0.05).roundToDouble();

  double get discountAmount => subtotal > 300 ? 50.0 : 0.0;

  double get grandTotal {
    if (_cart.isEmpty) return 0.0;
    final total = subtotal + deliveryFee + platformFee + taxesAndCharges - discountAmount;
    return total > 0 ? total : 0.0;
  }

  void toggleVegMode() {
    _isVegOnly = !_isVegOnly;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedFilter(String filter) {
    if (_selectedFilter == filter) {
      _selectedFilter = 'All';
    } else {
      _selectedFilter = filter;
    }
    notifyListeners();
  }

  void setAddress(String address) {
    _selectedAddress = address;
    notifyListeners();
  }

  int getItemQuantity(String itemId) {
    return _cart[itemId]?.quantity ?? 0;
  }

  void addToCart(FoodItem item, String restaurantName) {
    if (_cart.containsKey(item.id)) {
      _cart[item.id]!.quantity += 1;
    } else {
      _cart[item.id] = CartItem(
        foodItem: item,
        restaurantName: restaurantName,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    if (!_cart.containsKey(itemId)) return;

    if (_cart[itemId]!.quantity > 1) {
      _cart[itemId]!.quantity -= 1;
    } else {
      _cart.remove(itemId);
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  List<Restaurant> get filteredRestaurants {
    return MockData.restaurants.where((restaurant) {
      // Veg toggle filter
      if (_isVegOnly && !restaurant.isPureVeg) {
        // If restaurant has veg items, check if menu has veg items
        final hasVeg = restaurant.menu.any((item) => item.isVeg);
        if (!hasVeg) return false;
      }

      // Search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesName = restaurant.name.toLowerCase().contains(query);
        final matchesCuisine = restaurant.cuisine.toLowerCase().contains(query);
        final matchesFood = restaurant.menu.any((m) => m.name.toLowerCase().contains(query));
        if (!matchesName && !matchesCuisine && !matchesFood) return false;
      }

      // Filter chips
      if (_selectedFilter == 'Near & Fast' && !restaurant.isNearAndFast) {
        return false;
      }
      if (_selectedFilter == 'Rating 4.0+' && restaurant.rating < 4.0) {
        return false;
      }
      if (_selectedFilter == 'Pure Veg' && !restaurant.isPureVeg) {
        return false;
      }

      return true;
    }).toList();
  }

  void placeOrder() {
    if (_cart.isEmpty) return;

    final subOrders = itemsByStore.keys.map((store) {
      return StoreSubOrderStatus(
        restaurantName: store,
        status: "Preparing fresh items",
        estimatedReadyMinutes: 12,
      );
    }).toList();

    _currentOrder = OrderModel(
      orderId: 'ZOM-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      items: List.from(_cart.values),
      totalAmount: grandTotal,
      orderTime: DateTime.now(),
      status: OrderStatus.confirmed,
      deliveryAddress: _selectedAddress,
      subOrders: subOrders,
    );

    clearCart();
    _startOrderSimulation();
    notifyListeners();
  }

  void _startOrderSimulation() {
    _orderTrackerTimer?.cancel();
    _orderTrackerTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (_currentOrder == null) {
        timer.cancel();
        return;
      }

      switch (_currentOrder!.status) {
        case OrderStatus.confirmed:
          _currentOrder = OrderModel(
            orderId: _currentOrder!.orderId,
            items: _currentOrder!.items,
            totalAmount: _currentOrder!.totalAmount,
            orderTime: _currentOrder!.orderTime,
            status: OrderStatus.preparing,
            deliveryAddress: _currentOrder!.deliveryAddress,
            subOrders: _currentOrder!.subOrders,
          );
          notifyListeners();
          break;
        case OrderStatus.preparing:
          _currentOrder = OrderModel(
            orderId: _currentOrder!.orderId,
            items: _currentOrder!.items,
            totalAmount: _currentOrder!.totalAmount,
            orderTime: _currentOrder!.orderTime,
            status: OrderStatus.riderAssigned,
            deliveryAddress: _currentOrder!.deliveryAddress,
            subOrders: _currentOrder!.subOrders,
          );
          notifyListeners();
          break;
        case OrderStatus.riderAssigned:
          _currentOrder = OrderModel(
            orderId: _currentOrder!.orderId,
            items: _currentOrder!.items,
            totalAmount: _currentOrder!.totalAmount,
            orderTime: _currentOrder!.orderTime,
            status: OrderStatus.outForDelivery,
            deliveryAddress: _currentOrder!.deliveryAddress,
            subOrders: _currentOrder!.subOrders,
          );
          notifyListeners();
          break;
        case OrderStatus.outForDelivery:
          _currentOrder = OrderModel(
            orderId: _currentOrder!.orderId,
            items: _currentOrder!.items,
            totalAmount: _currentOrder!.totalAmount,
            orderTime: _currentOrder!.orderTime,
            status: OrderStatus.delivered,
            deliveryAddress: _currentOrder!.deliveryAddress,
            subOrders: _currentOrder!.subOrders,
          );
          timer.cancel();
          notifyListeners();
          break;
        case OrderStatus.delivered:
          timer.cancel();
          break;
      }
    });
  }

  @override
  void dispose() {
    _orderTrackerTimer?.cancel();
    super.dispose();
  }
}
