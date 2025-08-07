import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthDatasource {
  Future<UserEntity> register(String email, String password, String name);
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
}

class FirebaseAuthDatasource extends AuthDatasource {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<UserEntity> register(
    String email,
    String password,
    String name,
  ) async {
    final userCred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCred.user!;
    await _firestore.collection('users').doc(user.uid).set({
      'email': email,
      'name': name,
    });
    return UserEntity(uid: user.uid, email: email, name: name);
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final userCred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCred.user!;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    return UserEntity(uid: user.uid, email: email, name: doc['name']);
  }

  @override
  Future<void> logout() async => _auth.signOut();
}
