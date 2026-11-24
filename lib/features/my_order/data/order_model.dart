class OrderModel {
  final dynamic id;
  final String orderNumber;
  final String date;
  final String status;
  final String totalPrice;
  final String itemsCountText;
  final List<String> itemImages;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.totalPrice,
    required this.itemsCountText,
    required this.itemImages,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? json['orderId'] ?? 0,
      orderNumber: (json['id'] ?? json['orderNumber'] ?? '').toString(),
      date: json['date'] ?? json['orderDate'] ?? '',
      status: json['status'] ?? 'Processing',
      totalPrice: '${json['totalPrice'] ?? json['total'] ?? 0} EGP',
      itemsCountText: '${json['itemsCount'] ?? 3} items · ${json['deliveryMethod'] ?? 'Standard'}',
      itemImages: (json['itemImages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [
            'https://images.unsplash.com/photo-1541167760496-1628856ab772',
          ],
    );
  }
}