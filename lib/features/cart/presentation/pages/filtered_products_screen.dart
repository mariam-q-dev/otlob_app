import 'package:flutter/material.dart';
import 'package:otlob_app/features/home/presentation/widgets/product_card.dart';
import '../../../../core/services/api_service.dart';
import 'package:otlob_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class FilteredProductsScreen extends StatelessWidget {
  final String titleName;

  const FilteredProductsScreen({super.key, required this.titleName});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(titleName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        
      ),
      body: FutureBuilder<Either<Failure, List<dynamic>>>(
        future: apiService.getProducts(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepOrange));
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
              
              final filteredProducts = titleName.toLowerCase() == "all categories"
                  ? allProducts
                  : allProducts.where((product) {
                      final category = product['category'];
                      String catName = category is Map ? (category['name'] ?? '') : category.toString();
                      return catName.toLowerCase() == titleName.toLowerCase();
                    }).toList();

              if (filteredProducts.isEmpty) {
                return const Center(
                  child: Text(
                    'No products found for this category',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index] as Map<String, dynamic>;
                  return ProductCard(product: product); 
                },
              );
            },
          );
        },
      ),
    );
  }
}