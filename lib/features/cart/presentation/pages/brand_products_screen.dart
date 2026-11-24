import 'package:flutter/material.dart';
import 'package:otlob_app/core/utils/app_colors.dart';
import 'package:otlob_app/features/home/presentation/widgets/product_card.dart';
import '../../../../core/services/api_service.dart';
import 'package:otlob_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class BrandProductsScreen extends StatelessWidget {
  final String brandName;

  const BrandProductsScreen({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: FutureBuilder<Either<Failure, List<dynamic>>>(
        future: apiService.getProducts(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('An unexpected error occurred'));
          }


          return snapshot.data!.fold(
            (failure) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  failure.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            (allProducts) {
              
              final filteredProducts = allProducts.where((product) {
                final brandObj = product['brand'];
                String currentBrandName = '';
                
                if (brandObj is Map) {
                  currentBrandName = brandObj['name'] ?? '';
                } else if (brandObj is String) {
                  currentBrandName = brandObj;
                }

                return currentBrandName.toLowerCase() == brandName.toLowerCase();
              }).toList();

              if (filteredProducts.isEmpty) {
                return const Center(
                  child: Text(
                    'No products found for this brand',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                );
              }

              
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = filteredProducts[index] as Map<String, dynamic>;
                          return ProductCard(product: product);
                        },
                        childCount: filteredProducts.length,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}