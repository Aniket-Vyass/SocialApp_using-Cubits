import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:small_social_app/features/post/domain/enitites/post.dart';
import 'package:small_social_app/features/post/domain/repos/post_repo.dart';
import 'package:small_social_app/features/post/presentation/cubits/post_states.dart';
import 'package:small_social_app/features/storage/domain/storage_repo.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({required this.postRepo, required this.storageRepo})
    : super(PostsInitial());

  //create a new post
  Future<void> createPost(
    Post post, {
    String? imagePath,
    Uint8List? imageBytes,
  }) async {
    String? imageUrl;

    try {
      // handle image upload for mobile platforms (using file path)
      if (imagePath != null) {
        emit(PostUploading());
        imageUrl = await storageRepo.uploadProfileImageMobile(
          imagePath,
          post.id,
        );
      }
      // handle image upload for web platforms (using file bytes)
      else if (imageBytes != null) {
        emit(PostUploading());
        imageUrl = await storageRepo.uploadProfileImageWeb(imageBytes, post.id);
      }

      // give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      //create post in the backend
      postRepo.createPost(newPost);
    } catch (e) {
      emit(PostError('Failed to create post: $e'));
    }
  }

  // fetch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostLoading());
      final posts = await postRepo.fetchAllPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostError('Failed to fetch all posts'));
    }
  }
}
