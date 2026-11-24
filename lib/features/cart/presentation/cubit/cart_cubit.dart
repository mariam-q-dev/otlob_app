import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/core/services/api_service.dart';
import 'package:otlob_app/features/cart/data/models/card_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService apiService;

  CartCubit(this.apiService) : super(CartInitial());

  Future<void> getCartProducts() async {
    emit(CartLoading());
    
    final result = await apiService.getCartProducts();
    
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (products) => emit(CartSuccess(cartProducts: products)),
    );
  }

Future<void> removeFromCart(String productId) async {
  final result = await apiService.removeFromBasket(productId);

  result.fold(
    (failure) => emit(CartError(message: failure.message)),
    (success) {
      getCartProducts();
    },
  );
}

  Future<void> addToCart(Map<String, dynamic> basketData) async {
    final result = await apiService.addToBasket(basketData);
    
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (success) {
        getCartProducts(); 
      },
    );
  }
}