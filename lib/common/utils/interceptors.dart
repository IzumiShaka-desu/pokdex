import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// class AuthInterceptor extends Interceptor {
//   @override
//   Future onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     // get token from hive storage
//     final token = Hive.box<String>('auth').get('token');

//     // add token to header

//     options.headers,

//     return super.onRequest(options, handler);

//   }
// }

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return super
            .onError(TimeOutError(requestOptions: err.requestOptions), handler);
      // case DioExceptionType.unknown:

      //   }
      //   super.onError(err, handler);
      //   break;
      case DioExceptionType.cancel:
        // TODO: Handle this case.
        super.onError(err, handler);

        break;

      case DioExceptionType.badCertificate:
        return super.onError(
          BadGateway(requestOptions: err.requestOptions),
          handler,
        );
      default:
        switch (err.response?.statusCode) {
          case 500:
            return super.onError(
              InternalServerError(requestOptions: err.requestOptions),
              handler,
            );
          case 501:
            return super.onError(
              NotImplemented(requestOptions: err.requestOptions),
              handler,
            );
          case 502:
            return super.onError(
              BadGateway(requestOptions: err.requestOptions),
              handler,
            );
          case 503:
            return super.onError(
              ServiceUnavailable(requestOptions: err.requestOptions),
              handler,
            );
          case 504:
            return super.onError(
              GatewayTimeout(requestOptions: err.requestOptions),
              handler,
            );
          case 400:
            return super.onError(
              BadRequestError(
                requestOptions: err.requestOptions,
                responseData: err.response,
              ),
              handler,
            );
          case 409:
            return super.onError(
              BadRequestError(
                requestOptions: err.requestOptions,
                responseData: err.response,
              ),
              handler,
            );
          // super.onError(), handler);
          // break;
          case 401:
            return super.onError(
              UnAuthorizedError(
                requestOptions: err.requestOptions,
                responseData: err.response,
              ),
              handler,
            );
          case 403:
            return super.onError(
              ForbiddenError(
                requestOptions: err.requestOptions,
                responseData: err.response,
              ),
              handler,
            );
          case 404:
            return super.onError(
              NotFoundError(
                requestOptions: err.requestOptions,
                responseData: err.response,
              ),
              handler,
            );

          //     try {
          // super.onError(err, handler);
          //  // await _refreshToken();
          //   // final newRequest = err.requestOptions;
          //   // newRequest.headers["Authorization"] = "Bearer $token";
          //   // return handler.next(newRequest);
          //           await refreshToken();
          //           await retryRequest(err.requestOptions);
          //         } catch (_) {
          //           super.onError(
          //               UnAuthorizedException(requestOptions: err.requestOptions),
          //               handler);
          //         }
          //         break;
          //       case 500:
          //         super.onError(
          //             InternalServerException(requestOptions: err.requestOptions),
          //             handler);
          //         break;
          //     }

          // case DioExceptionType.other:
          //   super.onError(
          //       ConnectionException(requestOptions: err.requestOptions), handler);
          // break;
          default:
            super.onError(err, handler);
            break;
        }
    }
  }
}

class TimeOutError extends DioException {
  TimeOutError({required super.requestOptions});

  @override
  String get message => "Connection Timeout";
}

class UnAuthorizedError extends DioException {
  final Response? responseData;
  UnAuthorizedError({
    required super.requestOptions,
    required this.responseData,
  });

  @override
  String get message {
    final message = (responseData?.data.runtimeType == String
            ? responseData?.data
            : responseData?.data["message"]) ??
        "Unauthorized, please try again";
    debugPrint(responseData?.data);
    return message;
  }
}

class BadRequestError extends DioException {
  final Response? responseData;
  BadRequestError({
    required super.requestOptions,
    required this.responseData,
  });

  @override
  String get message =>
      (responseData?.data.runtimeType == String
          ? responseData?.data
          : responseData?.data["message"]) ??
      "Bad Request, please try again";
}

class InternalServerError extends DioException {
  InternalServerError({required super.requestOptions});

  @override
  String get message => "Internal Server Error";
}

class NotImplemented extends DioException {
  NotImplemented({required super.requestOptions});

  @override
  String get message => "Not Implemented";
}

class BadGateway extends DioException {
  BadGateway({required super.requestOptions});

  @override
  String get message => "Bad Gateway";
}

class ServiceUnavailable extends DioException {
  ServiceUnavailable({required super.requestOptions});

  @override
  String get message => "Service Unavailable";
}

class GatewayTimeout extends DioException {
  GatewayTimeout({required super.requestOptions});

  @override
  String get message => "Gateway Timeout";
}

class ForbiddenError extends DioException {
  final Response? responseData;
  ForbiddenError({
    required super.requestOptions,
    required this.responseData,
  });

  @override
  String get message =>
      (responseData?.data.runtimeType == String
          ? responseData?.data
          : responseData?.data["message"]) ??
      "Forbidden, please try again";
}

class NotFoundError extends DioException {
  final Response? responseData;
  NotFoundError({
    required super.requestOptions,
    required this.responseData,
  });

  @override
  String get message =>
      (responseData?.data.runtimeType == String
          ? responseData?.data
          : responseData?.data["message"]) ??
      "Not Found, please try again";
}
