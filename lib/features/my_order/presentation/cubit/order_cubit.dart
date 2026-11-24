import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/features/my_order/data/order_model.dart';
import '../../../../core/services/api_service.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final ApiService apiService;

  OrderCubit(this.apiService) : super(OrderInitial());

  void fetchOrders() async {
    emit(OrderLoading());
    
    final result = await apiService.getOrders();
    
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (ordersList) {
        List<OrderModel> orders = ordersList
            .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(OrderLoaded(orders: orders));
      },
    );
  }
}