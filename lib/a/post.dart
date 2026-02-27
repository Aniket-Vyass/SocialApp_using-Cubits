import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 1. Header - Username & more options
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Profile picture
                    CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.circle),
                      //backgroundImage: Icon(Icons.add),
                    ),
                    SizedBox(width: 10),
                    // Username
                    Text(
                      'username',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // More options icon
                Icon(Icons.more_vert),
              ],
            ),
          ),

          // 2. Post Image
          Image.network(
            'post_image_url',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 400,
          ),

          // 3. Like, comment, save icons
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 15),
                    Icon(Icons.comment),
                    SizedBox(width: 15),
                    Icon(Icons.share),
                  ],
                ),
                Icon(Icons.bookmark_border),
              ],
            ),
          ),

          // 4. Likes count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '1,234 likes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 5. Caption
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'username ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'This is the caption text',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 6. View all comments
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'View all 45 comments',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),

          // 7. Timestamp
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '2 hours ago',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),

          Divider(),
        ],
      ),
    );
  }
}
