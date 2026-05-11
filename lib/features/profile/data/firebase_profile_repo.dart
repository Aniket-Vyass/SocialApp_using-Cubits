import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:small_social_app/features/profile/domain/entities/profile_user.dart';
import 'package:small_social_app/features/profile/domain/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      print("FETCHING PROFILE FOR UID: $uid"); // 👈 check if uid is correct
      // get user doc from firestore
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();

      print("DOC EXISTS: ${userDoc.exists}"); // 👈 check if doc is found
      print("DOC DATA: ${userDoc.data()}"); // 👈 check what data is returned

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['username'],
            bio: userData['bio'] ?? '',
            profileImageUrl:
                userData['profileImage'] ?? '', //profileImageUrl in tutorial
          );
        }
      }

      return null;
    } catch (e) {
      print("ERROR: $e"); // 👈 see the actual error
      throw Exception('Failed to fetch User Profile !');
    }
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
