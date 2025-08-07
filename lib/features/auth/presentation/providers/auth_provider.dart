import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';

final authUserProvider = StateProvider<UserEntity?>((ref) => null);
