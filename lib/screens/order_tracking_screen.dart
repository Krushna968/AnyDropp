import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import '../models/order_model.dart';
import '../theme/app_theme.dart';

class OrderTrackingScreen extends StatelessWidget {
  final AppState appState;

  const OrderTrackingScreen({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final order = appState.currentOrder;

    if (order == null) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(title: const Text('Live Tracking')),
        body: const Center(child: Text('No active orders right now.')),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.orderId, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const Text('Arriving in 24-28 mins', style: TextStyle(fontSize: 11, color: AppTheme.nearFastGreen, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          // Order Status Header Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.lightRed,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delivery_dining, color: AppTheme.primaryRed, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getStatusTitle(order.status),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _getStatusSubtitle(order.status),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Visual Progress Stepper
                _buildProgressStepper(order.status),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Anydrop Multi-Store Orchestration Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Store Readiness Timeline',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.nearFastGreen.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Smart Batching',
                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppTheme.nearFastGreen),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ...order.subOrders.map((subOrder) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppTheme.nearFastGreen, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            subOrder.restaurantName,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                          ),
                        ),
                        Text(
                          subOrder.status,
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Delivery Partner Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.person, color: AppTheme.textPrimary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.riderName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Your Delivery Partner • Vaccinated',
                        style: TextStyle(fontSize: 11.5, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, color: AppTheme.nearFastGreen),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, color: AppTheme.primaryRed),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Order Items Summary Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 12),
                ...order.items.map((cartItem) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cartItem.quantity}x ${cartItem.foodItem.name}',
                          style: const TextStyle(fontSize: 12.5, color: AppTheme.textPrimary),
                        ),
                        Text(
                          '₹${cartItem.total.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(height: 20, color: AppTheme.dividerColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5)),
                    Text(
                      '₹${order.totalAmount.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.primaryRed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.confirmed:
        return 'Order Confirmed!';
      case OrderStatus.preparing:
        return 'Food is being prepared';
      case OrderStatus.riderAssigned:
        return 'Rider at store collecting items';
      case OrderStatus.outForDelivery:
        return 'Out for delivery!';
      case OrderStatus.delivered:
        return 'Order Delivered. Enjoy!';
    }
  }

  String _getStatusSubtitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.confirmed:
        return 'The stores have received your order';
      case OrderStatus.preparing:
        return 'Kitchens are preparing fresh dishes';
      case OrderStatus.riderAssigned:
        return 'Rider Rahul is completing pickups';
      case OrderStatus.outForDelivery:
        return 'Heading towards your location';
      case OrderStatus.delivered:
        return 'Delivered at HSR Layout, Sector 2';
    }
  }

  Widget _buildProgressStepper(OrderStatus currentStatus) {
    final steps = ['Confirmed', 'Preparing', 'Picked up', 'On Way', 'Delivered'];
    final currentIndex = currentStatus.index;

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex < currentIndex;
          return Expanded(
            child: Container(
              height: 3,
              color: isCompleted ? AppTheme.nearFastGreen : Colors.grey.shade300,
            ),
          );
        } else {
          final stepIndex = index ~/ 2;
          final isCurrent = stepIndex == currentIndex;
          final isCompleted = stepIndex <= currentIndex;

          return Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? (isCurrent ? AppTheme.primaryRed : AppTheme.nearFastGreen)
                      : Colors.grey.shade300,
                ),
                child: Center(
                  child: isCompleted && !isCurrent
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                  color: isCompleted ? AppTheme.textPrimary : AppTheme.textMuted,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
