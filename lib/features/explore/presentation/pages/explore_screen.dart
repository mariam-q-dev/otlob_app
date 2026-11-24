import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/features/cart/presentation/pages/brand_products_screen.dart';
import 'package:otlob_app/features/cart/presentation/pages/filtered_products_screen.dart';
import '../../../../core/services/api_service.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_state.dart';
import '../widgets/category_card.dart';
import '../widgets/brand_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit(ApiService())..getExploreData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Title
                const Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B263B), // Dark Navy
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Browse by category or brand",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),

                // Body content based on Cubit States
                Expanded(
                  child: BlocBuilder<ExploreCubit, ExploreState>(
                    builder: (context, state) {
                      if (state is ExploreLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF1B263B),
                          ),
                        );
                      } else if (state is ExploreLoaded) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CATEGORIES SECTION
                              const Text(
                                "CATEGORIES",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.categories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 2.2,
                                    ),
                                itemBuilder: (context, index) {
                                  final cat = state.categories[index];
                                  String catName = cat is Map
                                      ? (cat['name'] ?? 'Category')
                                      : cat.toString();
                                      String? catImage = cat is Map ? cat['pictureUrl'] : null;

                                  return CategoryCard(
                                    categoryName: catName,
                                    imageUrl: catImage,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FilteredProductsScreen(
                                                titleName: catName,
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              const SizedBox(height: 24),

                              // BRANDS SECTION
                              const Text(
                                "BRANDS",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.brands.length,
                                itemBuilder: (context, index) {
                                  final brand = state.brands[index];
                                  String brandName = brand is Map
                                      ? (brand['name'] ?? 'Brand')
                                      : brand.toString();

                                  return BrandCard(
                                    brandName: brandName,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BrandProductsScreen(
                                                brandName: brandName,
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (state is ExploreError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
