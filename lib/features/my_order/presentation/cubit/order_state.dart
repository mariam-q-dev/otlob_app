import 'package:otlob_app/features/my_order/data/order_model.dart';


abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded({required this.orders});
}

class OrderError extends OrderState {
  final String message;
  OrderError({required this.message});
}