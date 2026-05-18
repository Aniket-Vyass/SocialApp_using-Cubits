/*

    POST STATES

*/

import 'package:small_social_app/features/post/domain/enitites/post.dart';

abstract class PostState {}

// initial
class PostsInitial extends PostState {}

// loading...
class PostLoading extends PostState {}

// uploading...
class PostUploading extends PostState {}

// error
class PostError extends PostState {
  final String message;
  PostError(this.message);
}

//loaded
class PostsLoaded extends PostState {
  final List<Post> posts;
  PostsLoaded(this.posts);
}
