import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      home: InstagramFeedScreen(),
    );
  }
}

// ── App Screen ────────────────────────────────────────────────────────────────

class InstagramFeedScreen extends StatelessWidget {
  const InstagramFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.heart,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.paperplane,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          const Divider(height: 0.5, thickness: 0.5, color: Color(0xFFDBDBDB)),
          _buildStoriesRow(),
          const Divider(height: 0.5, thickness: 0.5, color: Color(0xFFDBDBDB)),
          const SizedBox(height: 4),
          const InstagramPostCard(
            username: 'aurora.captures',
            location: 'Lofoten Islands, Norway',
            gradientColors: [
              Color(0xFFF9CE34),
              Color(0xFFEE2A7B),
              Color(0xFF6228D7),
            ],
            postColor: Color(0xFF6A9FB5),
            likesCount: '48,291',
            caption:
                'Where the mountains meet the sea 🌊 Some places just feel like they exist outside of time.',
            commentCount: 312,
            timeAgo: '2 hours ago',
            isLiked: false,
          ),
          const InstagramPostCard(
            username: 'kai.wanders',
            location: 'Santorini, Greece',
            gradientColors: [
              Color(0xFF833AB4),
              Color(0xFFFD1D1D),
              Color(0xFFFCB045),
            ],
            postColor: Color(0xFFE8C4A0),
            likesCount: '103,847',
            caption:
                'Blue and white forever 🤍 There\'s something about this place that makes everything cinematic.',
            commentCount: 1024,
            timeAgo: '5 hours ago',
            isLiked: true,
          ),
          const InstagramPostCard(
            username: 'studio.mira',
            location: 'Kyoto, Japan',
            gradientColors: [
              Color(0xFF405DE6),
              Color(0xFF5851DB),
              Color(0xFF833AB4),
            ],
            postColor: Color(0xFFFFB7C5),
            likesCount: '27,560',
            caption:
                'Cherry blossom season hits different 🌸 Standing under a 300-year-old tree.',
            commentCount: 208,
            timeAgo: '1 day ago',
            isLiked: false,
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildStoriesRow() {
    final stories = [
      {'name': 'Your Story', 'isYou': true, 'color': const Color(0xFFB0BEC5)},
      {'name': 'mia.lens', 'isYou': false, 'color': const Color(0xFFEF9A9A)},
      {'name': 'kai', 'isYou': false, 'color': const Color(0xFF80CBC4)},
      {'name': 'aurora', 'isYou': false, 'color': const Color(0xFFCE93D8)},
      {'name': 'studio.mira', 'isYou': false, 'color': const Color(0xFF90CAF9)},
      {'name': 'nomad.eye', 'isYou': false, 'color': const Color(0xFFA5D6A7)},
      {'name': 'lens.folk', 'isYou': false, 'color': const Color(0xFFFFCC80)},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        itemCount: stories.length,
        itemBuilder: (context, i) {
          final isYou = stories[i]['isYou'] as bool;
          final color = stories[i]['color'] as Color;
          final name = stories[i]['name'] as String;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isYou
                            ? null
                            : const LinearGradient(
                                colors: [
                                  Color(0xFFF9CE34),
                                  Color(0xFFEE2A7B),
                                  Color(0xFF6228D7),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                        color: isYou ? Colors.grey.shade300 : null,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: color,
                          child: const Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    if (isYou)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0095F6),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFDBDBDB), width: 0.5)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(CupertinoIcons.home, size: 26, color: Colors.black),
              const Icon(
                CupertinoIcons.search,
                size: 26,
                color: Colors.black87,
              ),
              const Icon(
                CupertinoIcons.add_circled,
                size: 26,
                color: Colors.black87,
              ),
              const Icon(
                CupertinoIcons.play_rectangle,
                size: 26,
                color: Colors.black87,
              ),
              CircleAvatar(
                radius: 13,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  CupertinoIcons.person_fill,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Post Card ─────────────────────────────────────────────────────────────────

class InstagramPostCard extends StatefulWidget {
  final String username;
  final String location;
  final List<Color> gradientColors;
  final Color postColor;
  final String likesCount;
  final String caption;
  final int commentCount;
  final String timeAgo;
  final bool isLiked;

  const InstagramPostCard({
    super.key,
    required this.username,
    required this.location,
    required this.gradientColors,
    required this.postColor,
    required this.likesCount,
    required this.caption,
    required this.commentCount,
    required this.timeAgo,
    required this.isLiked,
  });

  @override
  State<InstagramPostCard> createState() => _InstagramPostCardState();
}

class _InstagramPostCardState extends State<InstagramPostCard>
    with SingleTickerProviderStateMixin {
  late bool _liked;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _liked = widget.isLiked;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() => _liked = !_liked);
    if (_liked) _ctrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: widget.postColor,
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                    Text(
                      widget.location,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.black),
            ],
          ),
        ),

        // ── Post placeholder
        GestureDetector(
          onDoubleTap: () {
            if (!_liked) _toggleLike();
          },
          child: Container(
            width: double.infinity,
            height: 400,
            color: widget.postColor.withOpacity(0.3),
            child: Center(
              child: Icon(
                CupertinoIcons.photo,
                size: 72,
                color: widget.postColor.withOpacity(0.6),
              ),
            ),
          ),
        ),

        // ── Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: _toggleLike,
                child: ScaleTransition(
                  scale: _scale,
                  child: Icon(
                    _liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    size: 27,
                    color: _liked ? const Color(0xFFED4956) : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                CupertinoIcons.chat_bubble,
                size: 26,
                color: Colors.black,
              ),
              const SizedBox(width: 16),
              const Icon(
                CupertinoIcons.paperplane,
                size: 25,
                color: Colors.black,
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.bookmark,
                size: 25,
                color: Colors.black,
              ),
            ],
          ),
        ),

        // ── Likes count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${widget.likesCount} likes',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
          ),
        ),

        // ── Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 13.5),
              children: [
                TextSpan(
                  text: '${widget.username} ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: widget.caption),
              ],
            ),
          ),
        ),

        // ── Comments hint
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'View all ${widget.commentCount} comments',
            style: const TextStyle(color: Color(0xFF8E8E8E), fontSize: 13),
          ),
        ),

        // ── Timestamp
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 2, bottom: 10),
          child: Text(
            widget.timeAgo.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 10,
              letterSpacing: 0.4,
            ),
          ),
        ),

        const Divider(height: 0.5, thickness: 0.5, color: Color(0xFFDBDBDB)),
        const SizedBox(height: 4),
      ],
    );
  }
}
