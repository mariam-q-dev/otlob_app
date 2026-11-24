import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/core/services/api_service.dart';
import 'package:otlob_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:otlob_app/features/cart/presentation/cubit/cart_cubit.dart';

void main() {
  runApp(const Otlob());
}

class Otlob extends StatelessWidget {
  const Otlob({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(ApiService())..getCartProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        // home: const MainLayout(), 
        home: const SignupScreen(), 
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}