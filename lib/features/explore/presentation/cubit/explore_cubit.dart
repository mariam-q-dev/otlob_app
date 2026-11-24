import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/api_service.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ApiService apiService;

  ExploreCubit(this.apiService) : super(ExploreInitial());

  void getExploreData() async {
    emit(ExploreLoading());

    final categoriesResult = await apiService.getCategories();
    final brandsResult = await apiService.getBrands();

    categoriesResult.fold(
      (failure) => emit(ExploreError(message: failure.message)),
      (categoriesList) {
        brandsResult.fold(
          (failure) => emit(ExploreError(message: failure.message)),
          (brandsList) {
            emit(ExploreLoaded(
              categories: categoriesList,
              brands: brandsList,
            ));
          },
        );
      },
    );
  }
}