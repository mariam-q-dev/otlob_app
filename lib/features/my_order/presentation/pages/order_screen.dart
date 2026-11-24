import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/features/my_order/presentation/widgets/order_card.dart';
import '../../../../core/services/api_service.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(ApiService())..fetchOrders(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Orders",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B263B),
                  ),
                ),
                const SizedBox(height: 4),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    int count = 0;
                    if (state is OrderLoaded) {
                      count = state.orders.length;
                    }
                    return Text(
                      "$count orders",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state is OrderLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF1B263B),
                          ),
                        );
                      } else if (state is OrderLoaded) {
                        if (state.orders.isEmpty) {
                          return const Center(
                            child: Text("No orders found."),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            final order = state.orders[index];
                            return OrderItemCard(
                              orderNumber: order.orderNumber,
                              date: order.date,
                              status: order.status,
                              totalPrice: order.totalPrice,
                              itemsCountText: order.itemsCountText,
                              itemImages: order.itemImages,
                            );
                          },
                        );
                      } else if (state is OrderError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}