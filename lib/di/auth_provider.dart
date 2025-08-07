import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_demo_app/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:news_demo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news_demo_app/features/auth/domain/repositories/auth_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(firebaseAuthProvider),
    ref.read(authDatasourceProvider),
  ),
);

final authDatasourceProvider = Provider<FirebaseAuthDatasource>(
  (ref) => FirebaseAuthDatasource(),
);
