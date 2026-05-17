import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:small_social_app/features/post/domain/enitites/post.dart';
import 'package:small_social_app/features/post/domain/repos/post_repo.dart';

class FirebasePostRepo implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // store all posts in a collection called 'posts'
  final CollectionReference postsCollection = FirebaseFirestore.instance
      .collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try {
      await postsCollection.doc(post.id).set(post.toJson());
    } catch (e) {
      throw Exception('Error creating post $e');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchAllPosts() async {
    try {
      //get all posts with most recent posts on top
      final postSnapshot = await postsCollection
          .orderBy('timestamp', descending: true)
          .get();

      // convert each firestore document from json to -> list of posts
      final List<Post> allPosts = postSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return allPosts;
    } catch (e) {
      throw Exception(' Error fetching post $e');
    }
  }

  @override
  Future<List<Post>> fetchPostByUserId(String userId) async {
    try {
      //fetch posts snapshot with this uid
      final postsSnapshot = await postsCollection
          .where('userId', isEqualTo: userId)
          .get();

      // covert firestore documents from json -> list of posts
      final userPosts = postsSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return userPosts;
    } catch (e) {
      throw UnimplementedError('Error fetching posts by user id : $e');
    }
  }
}
