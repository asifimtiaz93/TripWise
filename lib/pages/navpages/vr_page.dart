import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class vrPage extends StatelessWidget {
  const vrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover Bangladesh",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
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
                      SizedBox(height: 10),
                      Text(
                        "360 Videos",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      tourVideoCard(context, '-758gHCMn0M', 'Shugondha Beach'),
                      SizedBox(height: 10),
                      tourVideoCard(context, 'mH4tCp0utH4', 'Kaptai'),
                      SizedBox(height: 10),
                      Text(
                        "Tour Videos",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      tourVideoCard(context, 'sffrf1ZvtlM', 'Into the Nature'),
                      SizedBox(height: 10),
                      tourVideoCard(context, 'tbvK3nac8to', 'Puran Dhaka'),
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

  Widget tourVideoCard(BuildContext context, String videoId, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenVideoPlayer(videoId: videoId, title: title),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TourVideoPlayer(videoId: videoId),
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
              'Uploaded by Nofaer\n20 May 2024',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourVideoPlayer extends StatefulWidget {
  final String videoId;

  const TourVideoPlayer({Key? key, required this.videoId}) : super(key: key);

  @override
  _TourVideoPlayerState createState() => _TourVideoPlayerState();
}

class _TourVideoPlayerState extends State<TourVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
    );
  }
}

class FullScreenVideoPlayer extends StatelessWidget {
  final String videoId;
  final String title;

  const FullScreenVideoPlayer({Key? key, required this.videoId, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}
