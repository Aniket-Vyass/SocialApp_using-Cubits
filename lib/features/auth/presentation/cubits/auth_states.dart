/*


  Auth States - this class tells in which state/stage/step the process is 

  It's kind of a label/signal we create manually to tell the system
  that a certain process is completed, now make change.
*/

import 'package:small_social_app/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

//initial state
class AuthInitial extends AuthState {}

//loading... state
class AuthLoading extends AuthState {}

//authenticated state
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

//unauthenticated state
class Unauthenticated extends AuthState {}

//errors... state
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
