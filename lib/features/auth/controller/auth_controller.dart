import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/features/auth/repository/auth_repository.dart';
import 'package:my_project/model/user_model.dart';

import '../screen/login_screen.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider)),
);
final userProvider = StateProvider<UserModel?>((ref) => null);
final authStateChangeProvider = StreamProvider<User?>((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChanges;
});

class AuthController {
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository})
    : _authRepository = authRepository;
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;
  void signupScreen(UserModel user, BuildContext context) {
    _authRepository.signupScreen(user, context);
  }
  void loginScreen(String email, String password, BuildContext context){
    _authRepository.loginScreen(email, password, context);
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void updatePassword(String password,BuildContext context,WidgetRef ref){
    _authRepository.updatePassword(password,context,ref);
  }

  void restPassword(String email,BuildContext context,WidgetRef ref){
    _authRepository.resetPassword(email,context,ref);
  }


}
