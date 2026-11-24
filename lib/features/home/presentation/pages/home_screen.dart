import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/core/services/api_service.dart';
import 'package:otlob_app/features/home/presentation/cubit/home_cubit.dart';


import '../widgets/home_header.dart';
import '../widgets/address_selector.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/promo_banner.dart';
import '../widgets/categories_section.dart';
import '../widgets/brands_section.dart';
import '../widgets/popular_products_section.dart';
// import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ApiService())..getHomeData(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            } else if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (state is HomeSuccess) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: 16),
                    const AddressSelector(),
                    const SizedBox(height: 16),
                    const SearchBarWidget(),
                    const SizedBox(height: 20),
                    const PromoBanner(),
                    const SizedBox(height: 20),
                    
                    
                    CategoriesSection(categories: state.categories),
                    
                    const SizedBox(height: 20),
                    BrandsSection(brands: state.brands),
                    const SizedBox(height: 20),
                    
                    
                    PopularProductsSection(products: state.products),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
    );
  }
}