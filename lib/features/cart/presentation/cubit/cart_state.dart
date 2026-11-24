part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<ProductModel> cartProducts;
  final double totalPrice; 

  CartSuccess({required this.cartProducts, this.totalPrice = 0.0});
}

class CartActionSuccess extends CartState {
  final String message;
  CartActionSuccess({required this.message});
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}