// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:small_social_app/features/home/presentation/pages/home_page.dart';

class ProfilePage extends StatefulWidget {
  final void Function(int index, dynamic posts) onPostTap;
  final void Function(String username)? onUsernameChanged;

  const ProfilePage({
    super.key,
    required this.onPostTap,
    this.onUsernameChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String profileImage = '';
  String bio = '';
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

  Future<void> loadUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (mounted) {
      final newUsername = doc.data()?['username'] ?? 'Profile';
      setState(() {
        username = newUsername;
        profileImage = doc.data()?['profileImage'] ?? '';
        bio = doc.data()?['bio'] ?? '';
      });
      widget.onUsernameChanged?.call(newUsername);
    }
  }

  Future<void> loadPostData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (mounted) {
      setState(() {
        postCount = snapshot.docs.length.toString();
        posts = snapshot.docs.map((doc) => doc.data()).toList();
        imagePosts = posts.where((p) => p['isVideo'] == false).toList();
        videoPosts = posts.where((p) => p['isVideo'] == true).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar + stats ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: profileImage.isNotEmpty
                        ? NetworkImage(profileImage)
                        : null,
                    child: profileImage.isEmpty
                        ? const Icon(Icons.person, size: 45)
                        : null,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statColumn('Posts', postCount),
                        _statColumn('Followers', '0'),
                        _statColumn('Following', '0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Username ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            // ── Bio ────────────────────────────────────────────────
            if (bio.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Text(bio, style: const TextStyle(fontSize: 14)),
              ),

            const SizedBox(height: 12),

            // ── Tab bar ────────────────────────────────────────────
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.image)),
                Tab(icon: Icon(Icons.video_collection)),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  _buildGrid(posts, showVideoIcon: true),
                  _buildGrid(imagePosts),
                  _buildGrid(videoPosts, showVideoIcon: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _buildGrid(
    List<Map<String, dynamic>> items, {
    bool showVideoIcon = false,
  }) {
    if (items.isEmpty) {
      return const Center(child: Text('No posts yet'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final post = items[index];
        final isVideo = post['isVideo'] ?? false;
        final url = isVideo
            ? post['thumbnailUrl'] ?? ''
            : post['imageUrl'] ?? '';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              url.isNotEmpty
                  ? Image.network(url, fit: BoxFit.cover)
                  : Container(color: Colors.grey),
              if (showVideoIcon && isVideo)
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(Icons.play_circle_fill, color: Colors.white),
                ),
            ],
          ),
        );
      },
    );
  }
}

class UserPostsFeedPage {}
