/*

PROFILE STATES

*/

abstract class ProfileStates {}

//initial
class ProfileInitial extends ProfileStates {}

//loading...
class ProfileLoading extends ProfileStates {}

//loaded
class ProfileLoaded extends ProfileStates {}

//error
class ProfileError extends ProfileStates {}
