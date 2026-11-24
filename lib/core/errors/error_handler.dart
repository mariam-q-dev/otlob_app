// core/errors/error_handler.dart
import 'package:dio/dio.dart';
import 'package:otlob_app/core/errors/failure.dart';


class ErrorHandler implements Exception {
  final Failure failure;

  ErrorHandler.handle(dynamic error) : failure = _handleError(error);

  static Failure _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DataSource.connectTimeout.getFailure();
        case DioExceptionType.sendTimeout:
          return DataSource.sendTimeout.getFailure();
        case DioExceptionType.receiveTimeout:
          return DataSource.receiveTimeout.getFailure();
        case DioExceptionType.badCertificate:
          return DataSource.customDefault.getFailure();
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final responseData = error.response?.data;

          if (responseData is Map<String, dynamic>) {
            final message = responseData['message'];

            if (message is String && message.isNotEmpty) {
              final localizedMessage = _getLocalizedApiMessage(message);

              return Failure(
                code: statusCode ?? ResponseCode.customDefault,
                message: localizedMessage ?? message,
              );
            }
          }

          switch (statusCode) {
            case 400:
              return DataSource.badRequest.getFailure();

            case 401:
              return DataSource.unAuthorised.getFailure();

            case 403:
              return DataSource.forbidden.getFailure();

            case 404:
              return DataSource.notFound.getFailure();

            case 500:
              return DataSource.internalServerError.getFailure();

            default:
              return Failure(
                code: statusCode ?? ResponseCode.customDefault,
                message: ResponseMessage.customDefault,
              );
          }
        case DioExceptionType.cancel:
          return DataSource.cancel.getFailure();
        case DioExceptionType.connectionError:
          return DataSource.noInternetConnection.getFailure();
        case DioExceptionType.unknown:
          return DataSource.customDefault.getFailure();
        case DioExceptionType.transformTimeout:
          return DataSource.customDefault.getFailure();
      }
    } else {
      if (error is String && error == 'Email not found') {
        return Failure(
          code: ResponseCode.customDefault,
          message: ResponseMessage.emailNotFound,
        );
      }
      return DataSource.customDefault.getFailure();
    }
  }

  static String? _getLocalizedApiMessage(String message) {
    if (message.startsWith('Invalid PhoneNumber Or Password')) {
      return "Invalid PhoneNumber Or Password";
    }

    if (message.startsWith(
      'Your account has been locked due to multiple failed attempts',
    )) {
      return "Your account has been locked due to multiple failed attempts";
    }
    if (message.startsWith(
      'Endpoint Not Found',
    )) {
      return "An error occurred. Please try again later.";
    }

    if (message.startsWith('Account is locked until')) {
      return "Account is locked";
    }

    return null;
  }
}

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  customDefault,
}

extension DataSuorceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return Failure(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case DataSource.unAuthorised:
        return Failure(
          code: ResponseCode.unAuthorised,
          message: ResponseMessage.unAuthorised,
        );
      case DataSource.notFound:
        return Failure(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return Failure(
          code: ResponseCode.connectTimeout,
          message: ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case DataSource.receiveTimeout:
        return Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          code: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return Failure(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case DataSource.customDefault:
        return Failure(
          code: ResponseCode.customDefault,
          message: ResponseMessage.customDefault,
        );
    }
  }
}

class ResponseCode {
  static const int success = 200; 
  static const int noContent = 201; 
  static const int badRequest = 400; 
  static const int unAuthorised = 401; 
  static const int forbidden = 403; 
  static const int notFound = 404; 
  static const int internalServerError = 500; 

  static const int connectTimeout = -1; 
  static const int cancel = -2; 
  static const int receiveTimeout = -3; 
  static const int sendTimeout = -4; 
  static const int cacheError = -5; 
  static const int noInternetConnection = -6; 
  static const int customDefault = -7;
}

class ResponseMessage {
  static String success = "Success";
  static String noContent = "No Content";
  static String badRequest = "Bad Request";
  static String unAuthorised = "Unauthorised";
  static String forbidden = "Forbidden";
  static String notFound = "Not Found";
  static String internalServerError = "Internal Server Error";
  static String connectTimeout = "Connection Timeout";
  static String cancel = "Request Canceled";
  static String receiveTimeout = "Receive Timeout";
  static String sendTimeout = "Send Timeout";
  static String cacheError = "Cache Error";
  static String noInternetConnection = "No Internet Connection";
  static String customDefault = "Something went wrong";
  static String emailNotFound = "Email not found";
}