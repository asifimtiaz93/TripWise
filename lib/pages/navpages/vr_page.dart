import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class vrPage extends StatelessWidget {
  const vrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Explore Bangladesh in VR!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                color: Colors.blueAccent, // Background color instead of an image
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.black),
                onPressed: () {
                  // Add your settings functionality here
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: [
                          Chip(label: Text('Cox\'s Bazar')),
                          Chip(label: Text('Sylhet')),
                          Chip(label: Text('Chattogram')),
                          Chip(label: Text('Rangpur')),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "360 Videos",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            tourVideoCard('assets/videos/beach_cox.mp4', 'Shugondha Beach'),
                            tourVideoCard('assets/videos/kaptai.mp4', 'Kaptai'),
                            // Add more tourVideoCard widgets as needed
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Tour Videos",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            tourVideoCard('assets/videos/nature_bd.mp4', 'Into the Nature'),
                            tourVideoCard('assets/videos/puran_dhaka.mp4', 'Puran Dhaka'),
                            // Add more tourVideoCard widgets as needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget tourVideoCard(String videoUrl, String title) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: TourVideoPlayer(videoUrl: videoUrl),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Uploaded by Md. Rahman\n20 May 2024',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class TourVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const TourVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _TourVideoPlayerState createState() => _TourVideoPlayerState();
}

class _TourVideoPlayerState extends State<TourVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Container(
      height: 120,
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

