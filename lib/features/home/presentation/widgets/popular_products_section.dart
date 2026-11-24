// import 'package:flutter/material.dart';
// import '../../../../core/services/api_service.dart';
// import 'product_card.dart'; 

// class PopularProductsSection extends StatefulWidget {
//   const PopularProductsSection({super.key});

//   @override
//   State<PopularProductsSection> createState() => _PopularProductsSectionState();
// }

// class _PopularProductsSectionState extends State<PopularProductsSection> {
//   final ApiService _apiService = ApiService();
//   late Future<List<dynamic>> _productsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _productsFuture = _apiService.getProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Popular right now",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: const Text(
//                 "See all",
//                 style: TextStyle(
//                   color: Colors.deepOrange,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         FutureBuilder<List<dynamic>>(
//           future: _productsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(color: Colors.deepOrange),
//               );
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text('No products available'));
//             }

//             final products = snapshot.data!;

//             return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: products.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.72,
//               ),
//               itemBuilder: (context, index) {
//                 final product = products[index] as Map<String, dynamic>;
                
                
//                 return ProductCard(product: product);
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'product_card.dart';

class PopularProductsSection extends StatelessWidget {
  final List<dynamic> products;

  const PopularProductsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Popular right now",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "See all",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        products.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('No products available', style: TextStyle(color: Colors.grey)),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = products[index] as Map<String, dynamic>;
                  return ProductCard(product: product);
                },
              ),
      ],
    );
  }
}