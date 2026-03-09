import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String username;
  final String profileImage;
  final String imageUrl;
  final String caption;

  const Post({
    super.key,
    required this.username,
    required this.profileImage,
    required this.imageUrl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: const Text(
              'username',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Image.network(
            'https://picsum.photos/500',
            width: double.infinity,
            height: 402,
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.send)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('username  This is the caption of the post... '),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
