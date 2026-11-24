class ProductModel {
  final int id;
  final int brandId;
  final String productName;
  final String category;
  final String brand;
  final double price;
  final String imageUrl;
  final int quantity; 

  ProductModel({
    required this.id,
    required this.brandId,
    required this.productName,
    required this.category,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.quantity = 1, 
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      brandId: json['brandId']?? json['productId'] ?? 0,
      productName: json['productName'] ?? json['name'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] is Map ? (json['brand']['name'] ?? '') : (json['brand'] ?? ''),
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? json['pictureUrl'] ?? '',
      quantity: json['quantity'] ?? 1, 
    );
  }
}