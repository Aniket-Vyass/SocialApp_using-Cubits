/*

  Auth Repository - Outlines the possible auth methods/operations for this app

  Any class that extends/implements it must provide the actual code for those methods
  in our case that is firebase_auth_repo.dart
*/

import 'package:small_social_app/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  );
  Future<AppUser?> logout();
  Future<AppUser?> getCurrentUser();
  Future<String> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
  Future<AppUser?> signInWithGoogle();
}
