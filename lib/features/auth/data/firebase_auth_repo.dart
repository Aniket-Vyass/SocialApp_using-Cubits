/*

FIREBASE IS OUR BACKEND HERE

*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:small_social_app/features/auth/domain/entities/app_user.dart';
import 'package:small_social_app/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  //access to Firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //LOGIN: Emali & Password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //attempt sign in/log in (same thing)
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      //return user
      return user;

      //Catch any errors
    } catch (e) {
      throw Exception('Login Falied: $e');
    }
  }

  //REGISTER OR SIGN UP(same thing): Email & Password
  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      //attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      //return user
      return user;

      //Catch any errors
    } catch (e) {
      throw Exception('Registration Falied: $e');
    }
  }

  //DELETE Account
  @override
  Future<void> deleteAccount() async {
    try {
      // get current user
      final user = firebaseAuth.currentUser;

      //check if there is a logged in user
      if (user == null) throw Exception('No User logged in..');

      //logout
      await logout();
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  //GET CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async {
    // get current logged in user form firebase
    final firebaseUser = firebaseAuth.currentUser;

    // check if logged in user or not
    if (firebaseUser == null) return null;

    // logged in user exists
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  //LOGOUT
  @override
  Future<AppUser?> logout() async {
    await firebaseAuth.signOut();
    return null;
  }

  // RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent! Check your inbox!";
    } catch (e) {
      return 'An error occoured $e';
    }
  }

  //Sign In with Google
  Future<AppUser?> signInWithGoogle() async {
    try {
      // create an instance first
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // now call .signIn() on the instance
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      //user cancelled sign-in
      if (gUser == null) return null;

      //obtain the auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      //create a credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //sign-in with these credentials
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      //firebase user
      final firebaseUser = userCredential.user;

      //user cancelled the sign-in
      if (firebaseUser == null) return null;

      AppUser appUser = AppUser(
        uid: firebaseUser.uid!,
        email: firebaseUser.email ?? '',
      );

      return appUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
