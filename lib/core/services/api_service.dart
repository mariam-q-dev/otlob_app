import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:otlob_app/core/errors/error_handler.dart';
import 'package:otlob_app/core/errors/failure.dart';
import 'package:otlob_app/features/cart/data/models/card_model.dart';

import 'dio_factory.dart';

class ApiService {
  final Dio _dio = DioFactory.getDio();

  Future<Either<Failure, List<ProductModel>>> getCartProducts() async {
    try {
      final response = await _dio.get('/api/Basket');

      List data = [];
      if (response.data is List) {
        data = response.data; 
      } else if (response.data is Map) {
        data = response.data['items'] ?? [];
      }

      List<ProductModel> products = data
          .map((item) => ProductModel.fromJson(item))
          .toList();
      return Right(products);
    } catch (e) {
      log("GET CART ERROR: $e");
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<dynamic>>> getProducts() async {
    try {
      final response = await _dio.get('/api/Products');
      log("API RESPONSE DATA: ${response.data}");

      List<dynamic> products = [];
      if (response.data is List) {
        products = response.data as List<dynamic>;
      } else if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        products = data['data'] ?? data['products'] ?? data['items'] ?? [];
      }
      return Right(products);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<dynamic>>> getCategories() async {
  try {
    final response = await _dio.get('/api/Products/categories');
    
    List categoriesList = [];
    if (response.data is List) {
      categoriesList = response.data;
    } else if (response.data is Map) {
      categoriesList = response.data['items'] ?? response.data['data'] ?? [];
    }
    
    return Right(categoriesList);
  } catch (e) {
    log("GET CATEGORIES ERROR: $e");
    return Left(ErrorHandler.handle(e).failure);
  }
}

  Future<Either<Failure, List<dynamic>>> getBrands() async {
    try {
      final result = await getProducts();
      return  await result.fold((failure) => Left(failure), (products) {
        final brandsMap = <String, dynamic>{};
        for (var product in products) {
          final brand = product['brand'];
          if (brand != null) {
            String brandName = brand is Map
                ? (brand['name'] ?? '')
                : brand.toString();
            if (brandName.isNotEmpty) {
              brandsMap[brandName] = brand;
            }
          }
        }
        return Right(brandsMap.values.toList());
      });
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, dynamic>> addToBasket(
    Map<String, dynamic> basketData,
  ) async {
    try {
      final requestBody = {
        'id': basketData['id'],
        'productId': basketData['id'],
        'productName': basketData['productName'],
        'price': basketData['price'],
        'quantity': basketData['quantity'] ?? 1,
        'imageUrl': basketData['imageUrl'],
        'brand': basketData['brand'],
      };

      final response = await _dio.post('/api/Basket', data: requestBody);

      return Right(response.data);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

Future<Either<Failure, dynamic>> getBasket() async {
  try {
    final response = await _dio.get('/api/Basket');
    return Right(response.data);
  } catch (e) {
    log("GET BASKET ERROR: $e");
    return Left(ErrorHandler.handle(e).failure);
  }
}


Future<Either<Failure, dynamic>> removeFromBasket(String productId) async {
  try {
    final response = await _dio.delete(
      '/api/Basket',
      queryParameters: {'id': productId},
    );

    return Right(response.data);
  } catch (e) {
    log("DELETE ERROR: $e");
    return Left(ErrorHandler.handle(e).failure);
  }
}

Future<Either<Failure, List<dynamic>>> getOrders() async {
  try {
    final response = await _dio.get('/api/Orders');
    
    List ordersList = [];
    if (response.data is List) {
      ordersList = response.data;
    } else if (response.data is Map) {
      ordersList = response.data['items'] ?? response.data['data'] ?? [];
    }
    
    return Right(ordersList);
  } catch (e) {
    log("GET ORDERS ERROR: $e");
    if (e is DioException) {
      log("SERVER ERROR RESPONSE: ${e.response?.data}"); 
    }
     return Left(ErrorHandler.handle(e).failure);
    
  }
}

Future<Either<Failure, void>> createOrder(Map<String, dynamic> orderData) async {
  try {
    log("SENDING ORDER DATA: $orderData"); 
    final response = await _dio.post(
      '/api/Orders',
      data: orderData,
    ); 
    log("ORDER CREATED SUCCESSFULLY: ${response.data}");
    return const Right(null);
  } catch (e) {
    log("CREATE ORDER ERROR: $e");
    if (e is DioException) {
      log("ORDER ERROR RESPONSE: ${e.response?.data}");
    }
    return Left(ErrorHandler.handle(e).failure);
  }
}

  Future<Either<Failure, Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/api/Account/Login',
        data: {'email': email, 'password': password},
      );
      return Right(response.data);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/Account/Register',
        data: {
          'displayName': name,
          'email': email,
          'phoneNumber': phone,
          'password': password,
        },
      );
      return Right(response.data);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
