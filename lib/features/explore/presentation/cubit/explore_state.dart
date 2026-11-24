abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<dynamic> categories;
  final List<dynamic> brands;

  ExploreLoaded({required this.categories, required this.brands});
}

class ExploreError extends ExploreState {
  final String message;
  ExploreError({required this.message});
}