part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<dynamic> products;
  final List<dynamic> categories;
  final List<dynamic> brands;

  HomeSuccess({required this.products, required this.categories, required this.brands});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}