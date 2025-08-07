import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External packages
  await Hive.initFlutter();
  sl.registerLazySingleton(() => Dio());
  // More registrations for repositories, datasources, usecases etc.
}
