import 'cart_item.dart';

enum OrderStatus {
  confirmed,
  preparing,
  riderAssigned,
  outForDelivery,
  delivered,
}

class StoreSubOrderStatus {
  final String restaurantName;
  final String status;
  final int estimatedReadyMinutes;

  StoreSubOrderStatus({
    required this.restaurantName,
    required this.status,
    required this.estimatedReadyMinutes,
  });
}

class OrderModel {
  final String orderId;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderTime;
  final OrderStatus status;
  final String deliveryAddress;
  final String riderName;
  final String riderPhone;
  final List<StoreSubOrderStatus> subOrders;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.orderTime,
    required this.status,
    required this.deliveryAddress,
    this.riderName = "Rahul Sharma",
    this.riderPhone = "+91 98765 43210",
    this.subOrders = const [],
  });
}
