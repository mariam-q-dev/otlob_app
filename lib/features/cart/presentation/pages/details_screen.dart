import 'package:flutter/material.dart';
import 'package:otlob_app/core/services/api_service.dart'; 
class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  final ApiService _apiService = ApiService();
  bool _isLoading = false; 
  @override
  Widget build(BuildContext context) {
    final String name = widget.product['name'] ?? widget.product['productName'] ?? 'Product Name';
    final double price = (widget.product['price'] ?? 0.0).toDouble();
    final String imageUrl = widget.product['pictureUrl'] ?? widget.product['imageUrl'] ?? '';
    final String description = widget.product['description'] ?? 'No description available for this item.';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( 
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 280,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 280,
                              color: Colors.grey.shade200,
                              child: const Center(child: Text('Image not available')),
                            );
                          },
                        )
                      : Container(
                          height: 280,
                          color: Colors.grey.shade200,
                          child: const Center(child: Text('Image not available')),
                        ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "$price EGP",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.deepOrange),
                              onPressed: () {
                                setState(() => quantity++);
                              },
                            ),
                          ],
                        ),
                        
                        // زر الإضافة للسلة مع حالة التحميل
                        _isLoading
                            ? const CircularProgressIndicator(color: Colors.deepOrange)
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  
                                  final basketData = {
                                    'id': widget.product['id'] ?? 0,
                                    'productName': name,
                                    'price': price,
                                    'quantity': quantity,
                                    'imageUrl': imageUrl,
                                    'brand': widget.product['brand'] is Map 
                                        ? widget.product['brand']['name'] 
                                        : (widget.product['brand'] ?? ''),
                                  };

                                  try {
                                    
                                    await _apiService.addToBasket(basketData);

                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Added to cart successfully! 🛒'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to add: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                                child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 16)),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}