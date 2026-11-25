// lib/services/auth_interceptor.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'secure_storage.dart';

class AuthInterceptor extends Interceptor {
  static const String _apiKeyHeader = 'x-api-key'; // change if your API expects a different name

  final SecureStorage _storage = SecureStorage();

  // Enable **only ONE** of these flags – pick the scheme your API uses.
  final bool useApiKeyHeader;
  final bool useBearerHeader;
  final bool useBasicAuth;

  AuthInterceptor({
    this.useApiKeyHeader = true,
    this.useBearerHeader = false,
    this.useBasicAuth = false,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final secret = await _storage.read(key: 'api_key');
    if (secret == null) {
      return handler.reject(
        DioException(requestOptions: options, error: 'API key not found in secure storage'),
      );
    }

    if (useApiKeyHeader) {
      options.headers[_apiKeyHeader] = secret;
    } else if (useBearerHeader) {
      options.headers['Authorization'] = 'Bearer $secret';
    } else if (useBasicAuth) {
      final encoded = base64Encode(utf8.encode(secret)); // secret = "username:password"
      options.headers['Authorization'] = 'Basic $encoded';
    }

    // Ensure JSON is used
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }
}