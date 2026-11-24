import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/core/services/api_service.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit(this.apiService) : super(HomeInitial());


  Future<void> getHomeData() async {
    emit(HomeLoading());

   
    final productsResult = await apiService.getProducts();
    final categoriesResult = await apiService.getCategories();

   
    productsResult.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (productsData) {
        categoriesResult.fold(
          (failure) => emit(HomeError(message: failure.message)),
          (categoriesData) {
            emit(HomeSuccess(
              products: productsData,
              categories: categoriesData,
              brands: productsData.map((product) => product['brand']).toSet().toList(),
            ));
          },
        );
      },
    );
  }
}