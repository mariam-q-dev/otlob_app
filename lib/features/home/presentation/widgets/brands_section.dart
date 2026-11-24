import 'package:flutter/material.dart';
import 'package:otlob_app/features/cart/presentation/pages/brand_products_screen.dart';

class BrandsSection extends StatefulWidget {
  final List<dynamic> brands; 

  const BrandsSection({super.key, required this.brands});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.brands.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Brands",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.brands.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              final brandItem = widget.brands[index];
              String brandName = '';

              if (brandItem is Map) {
                brandName = brandItem['name'] ?? brandItem['title'] ?? brandItem.toString();
              } else {
                brandName = brandItem.toString();
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BrandProductsScreen(
                        brandName: brandName,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black87 : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.black87 : Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    brandName, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}