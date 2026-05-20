import 'package:flutter/material.dart';
import 'package:small_social_app/features/home/presentation/components/my_drawer.dart';
import 'package:small_social_app/features/post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        // upload new post button
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadPostPage()),
            ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      //Drawer
      drawer: MyDrawer(),
    );
  }
}
