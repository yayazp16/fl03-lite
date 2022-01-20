import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl03_lite/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<FireBaseAuthService>(
    (r) => FireBaseAuthService(FirebaseAuth.instance));

final authState = StreamProvider<User?>((ref) => ref.read(authProvider).user);
