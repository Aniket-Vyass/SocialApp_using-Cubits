// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required String uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final String currentUserId = ;
  String username = '';
  String profileImage = '';
  String postCount = '0';
  List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> imagePosts = [];
  List<Map<String, dynamic>> videoPosts = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadPostData();
  }

  //users collection me se current-user ki uid fetch karo, uid me sab info hoti h eg. username, pfp
  Future<void> loadUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (mounted) {
      // "if mounted" is used a security if user exits the page before it opens
      // only call setState if the widget is still alive, if dead do not call setState()
      setState(() {
        username = doc.data()?['username'] ?? 'Profile';
        profileImage = doc.data()?['profileImage'] ?? '';
      });
    }
  }

  //posts collection me se
  Future<void> loadPostData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (mounted) {
      setState(() {
        postCount = snapshot.docs.length.toString();
        posts = snapshot.docs.map((doc) => doc.data()).toList();
        imagePosts = posts.where((post) => post['isVideo'] == false).toList();
        videoPosts = posts.where((post) => post['isVideo'] == true).toList();
      });
    }
  }

  Future<void> pickImage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(username)),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profileImage.isNotEmpty
                                ? NetworkImage(profileImage)
                                : null,
                            child: profileImage.isEmpty
                                ? Icon(Icons.person)
                                : null,
                          ),

                          Positioned(
                            bottom: 02,
                            right: 05,

                            child: GestureDetector(
                              onTap: pickImage,
                              child: CircleAvatar(
                                radius: 12,
                                child: Icon(Icons.add, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 39),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Posts',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              postCount,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 17), //gap btw posts and followers
                        Column(
                          children: [
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ), //gap btw followers and followers count
                            Text(
                              '0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              'Following',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ), //gap btw Following and following count
                            Text(
                              '0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              //TAB BAR
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.image)),
                  Tab(icon: Icon(Icons.video_collection)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    //TAB 1: all posts
                    GridView.builder(
                      padding: EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final isVideo = post['isVideo'] ?? false;
                        final displayUrl = isVideo
                            ? post['thumbnailUrl'] ?? ''
                            : post['imageUrl'] ?? '';

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            displayUrl.isNotEmpty
                                ? Image.network(displayUrl, fit: BoxFit.cover)
                                : Container(color: Colors.grey),

                            if (isVideo)
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    //TAB 2: ONLY IMAGES
                    GridView.builder(
                      padding: EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: imagePosts.length,
                      itemBuilder: (context, index) {
                        final imageUrl = imagePosts[index]['imageUrl'] ?? '';

                        return imageUrl.isNotEmpty
                            ? Image.network(imageUrl, fit: BoxFit.cover)
                            : Container(color: Colors.grey);
                      },
                    ),

                    //TAB 3: ONLY VIDEOS/REELS
                    GridView.builder(
                      padding: EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: videoPosts.length,
                      itemBuilder: (context, index) {
                        final thumbnailUrl =
                            videoPosts[index]['thumbnailUrl'] ?? '';

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            thumbnailUrl.isNotEmpty
                                ? Image.network(thumbnailUrl, fit: BoxFit.cover)
                                : Container(color: Colors.grey),

                            Positioned(
                              top: 6,
                              right: 6,
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
