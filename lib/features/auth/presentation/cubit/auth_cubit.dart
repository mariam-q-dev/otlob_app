import 'package:bloc/bloc.dart';
import 'package:otlob_app/core/services/api_service.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService apiService;

  AuthCubit(this.apiService) : super(AuthInitial());


  // Future<void> login({required String email, required String password}) async {
  //   emit(LoginLoading());

  //   final result = await apiService.login(email, password);

  //   result.fold(
  //     (failure) => emit(LoginError(message: failure.message)),
  //     (data) => emit(LoginSuccess(userModel: data)),
  //   );
  // }
  Future<void> login({required String email,required String password})async {
    emit(LoginLoading());
    final result = await apiService.login(email, password);
    result.fold(
      (failure)=>emit(LoginError(message: failure.message)),
      (data)=>emit(LoginSuccess(userModel: data)),
    );
  }


  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoading());

    final result = await apiService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    result.fold(
      (failure) => emit(RegisterError(message: failure.message)),
      (data) => emit(RegisterSuccess(userModel: data)),
    );
  }
}