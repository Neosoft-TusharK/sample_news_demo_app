import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/url_provider.dart';
import '../core/network/api_key_interceptor.dart';
import '../core/services/secure_storage_service.dart';

final secureStorageProvider = Provider(
  (_) => SecureStorageService(const FlutterSecureStorage()),
);

final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final secureStorage = ref.read(secureStorageProvider);

  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(
    ApiKeyInterceptor(secureStorage, targetBaseUrl: baseUrl),
  );

  return dio;
});
