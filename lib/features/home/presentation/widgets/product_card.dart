import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlob_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:otlob_app/features/cart/presentation/pages/details_screen.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final String name = product['name'] ?? 'Product Name';
    final double price = (product['price'] ?? 0.0).toDouble();
    final String imageUrl = product['pictureUrl'] ?? '';

    final brandObj = product['brand'];
    String brandName = '';
    if (brandObj is Map) {
      brandName = brandObj['name'] ?? '';
    } else if (brandObj is String) {
      brandName = brandObj;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 110,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Text('Image not available', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 110,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text('Image not available', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (brandName.isNotEmpty)
                    Text(
                      brandName,
                      style: const TextStyle(color: Colors.deepOrange, fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$price EGP",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white, size: 14),
                          constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            final basketData = {
                              'id': product['id'] ?? 0,
                              'productName': name,
                              'price': price,
                              'quantity': 1,
                              'imageUrl': imageUrl,
                              'brand': brandName,
                            };

                            
                            context.read<CartCubit>().addToCart(basketData);

                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to cart successfully! 🛒'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}