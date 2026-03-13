/*

  PROFILE STATES

*/

import 'package:small_social_app/features/profile/domain/entities/profile_user.dart';

abstract class ProfileState {}

//initial
class ProfileInitial extends ProfileState {}

// loading..
class ProfileLoading extends ProfileState {}

//loaded..
class ProfileLoaded extends ProfileState {
  ProfileLoaded(ProfileUser user);
}

//error
class ProfileError extends ProfileState {
  ProfileError(String s);
}
