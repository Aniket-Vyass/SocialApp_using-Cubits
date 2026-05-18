import "package:small_social_app/features/post/domain/enitites/post.dart";

abstract class PostRepo {
  Future<List<Post>> fetchAllPosts();
  Future<void> createPost(Post newPost);
  Future<void> deletePost(String postId);
  Future<List<Post>> fetchPostByUserId(String userId);
}
