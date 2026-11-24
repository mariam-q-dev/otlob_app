import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String status;
  final String totalPrice;
  final String itemsCountText;
  final List<String> itemImages;

  const OrderItemCard({
    Key? key,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.totalPrice,
    required this.itemsCountText,
    required this.itemImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDelivered = status.toLowerCase() == 'delivered';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order Number & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #$orderNumber",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B263B), 
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDelivered 
                      ? Colors.green 
                      : Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDelivered ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDelivered ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Date
          Text(
            date,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          const SizedBox(height: 12),
          
          // Images row
          Row(
            children: itemImages.map((img) => Container(
              margin: const EdgeInsets.only(right: 8),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            )).toList(),
          ),
          
          const Divider(height: 24),

          // Footer: Items count & Total Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemsCountText,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              Text(
                totalPrice,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B263B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}