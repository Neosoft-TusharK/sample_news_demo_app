import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';

class ApiKeyInterceptor extends Interceptor {
  final SecureStorageService secureStorage;
  final String targetBaseUrl;

  ApiKeyInterceptor(this.secureStorage, {required this.targetBaseUrl});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Check if the request URL starts with the targetBaseUrl
      if (options.uri.toString().startsWith(targetBaseUrl)) {
        // Fetch the API key from secure storage
        final apiKey = await secureStorage.getApiKey();
        if (apiKey != null && apiKey.isNotEmpty) {
          // Add apiKey only if not already set
          if (!options.queryParameters.containsKey('apiKey')) {
            options.queryParameters['apiKey'] = apiKey;
          }
        }
      }
    } catch (e) {
      // Log but don't crash the request
      print('ApiKeyInterceptor error: $e');
    }

    return handler.next(options);
  }
}
