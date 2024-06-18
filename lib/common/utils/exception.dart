import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'failure.dart';

class ServerException implements Exception {
  final String? message;
  ServerException({
    this.message = "We can't proceed your request. Please try again later.",
  });
}

class ForbiddenException implements Exception {
  final String? message;
  ForbiddenException({
    this.message = "You don't have permission to access this resource.",
  });
}

class ServiceUnavailableException implements Exception {
  final String? message;
  ServiceUnavailableException({
    this.message =
        "The server is currently unavailable, please try again later.",
  });
}

class NotFoundException implements Exception {
  final String? message;
  NotFoundException({
    this.message = "The resource you are looking for is not found.",
  });
}

class UnAuthorizedException implements Exception {
  final String message;
  UnAuthorizedException(this.message);
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class TimeoutException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class HandshakeException implements Exception {
  final String message;
  HandshakeException(this.message);
}

Future<Either<Failure, T>> tryCatch<T>(
  Future<T> Function() computation, {
  FutureOr? onFinally,
}) async {
  try {
    final response = await computation();
    return Right(response);
  } on BadRequestException catch (e) {
    return Left(
      ClientFailure(e.message),
    );
  } on UnAuthorizedException catch (e) {
    return Left(
      ClientFailure(e.message),
    );
  } on ServerException catch (e) {
    return Left(
      ServerFailure(
          e.message ?? "we can't proceed you request, please try again later."),
    );
  } on ForbiddenException catch (e) {
    return Left(
      ServerFailure(
          e.message ?? "we can't proceed you request, please try again later."),
    );
  } on ServiceUnavailableException catch (e) {
    return Left(
      ServerFailure(
          e.message ?? "we can't proceed you request, please try again later."),
    );
  } on NotFoundException catch (e) {
    return Left(
      ServerFailure(
          e.message ?? "we can't proceed you request, please try again later."),
    );
  } on TimeoutException {
    return const Left(
      ServerFailure("Connection timeout, please try again later."),
    );
  } on DatabaseException catch (e) {
    return Left(
      ServerFailure(e.message),
    );
  } on HandshakeException {
    return const Left(
      ServerFailure("Connection timeout, please try again later."),
    );
  } on CacheException catch (e) {
    return Left(
      ServerFailure(e.message),
    );
  } catch (e, s) {
    // FirebaseCrashlytics.instance.recordError(e, s);
    debugPrint(e.toString());
    debugPrint(s.toString());

    return const Left(
      ServerFailure(
        "we can't proceed you request, please try again later.",
      ),
    );
  } finally {}
}
