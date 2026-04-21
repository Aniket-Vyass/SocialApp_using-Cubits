import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:small_social_app/features/post/presentation/profile/domain/entities/profile_user.dart';
import 'package:small_social_app/features/post/presentation/profile/domain/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      // get user doc from firestore
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'],
            profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }

      return null;
    } catch (e) {}
    //TODO: implement fetchUserProfile
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfile) async {
    try {
      //convert updated file to json to store in firebase

      await firebaseFirestore
          .collection('users')
          .doc(updatedProfile.uid)
          .update({
            'bio': updatedProfile.bio,
            'profileImageUrl': updatedProfile.profileImageUrl,
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
