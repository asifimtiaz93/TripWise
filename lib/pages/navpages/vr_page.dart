// lib/pages/navpages/vr_page.dart

import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:video_player/video_player.dart';
=======
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
>>>>>>> Stashed changes

class vrPage extends StatefulWidget {
  const vrPage({super.key});

  @override
  _vrPageState createState() => _vrPageState();
}

class _vrPageState extends State<vrPage> {
  List<String> _selectedChips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Explore Bangladesh in VR",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[900],
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
                        children: List<Widget>.generate(
                          _chipLabels.length,
                              (int index) {
                            return FilterChip(
                              label: Text(_chipLabels[index]),
                              selected: _selectedChips.contains(_chipLabels[index]),
                              selectedColor: Colors.black,
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: _selectedChips.contains(_chipLabels[index]) ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              side: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedChips.add(_chipLabels[index]);
                                  } else {
                                    _selectedChips.removeWhere((String name) => name == _chipLabels[index]);
                                  }
                                });
                              },
                              showCheckmark: false,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Explore Beautiful Bangladesh",
                        style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            tourVideoCard(context, 'assets/videos/beach_cox.mp4', 'Shugondha Beach'),
                            tourVideoCard(context, 'assets/videos/kaptai.mp4', 'Kaptai'),
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
                            tourVideoCard(context, 'assets/videos/nature_bd.mp4', 'Into the Nature'),
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

<<<<<<< Updated upstream
  Widget tourVideoCard(BuildContext context, String videoUrl, String title) {
=======
  static const List<String> _chipLabels = [
    'Cox\'s Bazar',
    'Sylhet',
    'Chattogram',
  ];

  Widget tourVideoCard(BuildContext context, String videoId, String title) {
>>>>>>> Stashed changes
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenVideoPlayer(videoUrl: videoUrl, title: title),
          ),
        );
      },
      child: Container(
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
  final String videoUrl;

  const TourVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _TourVideoPlayerState createState() => _TourVideoPlayerState();
}

class _TourVideoPlayerState extends State<TourVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _toggleFullScreen(BuildContext context) {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
    if (_isFullScreen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.fullscreen_exit),
            ),
          ),
        ),
      ).then((_) => setState(() {
        _isFullScreen = false;
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _togglePlayPause,
          child: _controller.value.isInitialized
              ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              if (!_isPlaying)
                Icon(
                  Icons.play_arrow,
                  size: 64,
                  color: Colors.white,
                ),
            ],
          )
              : Container(
            height: 120,
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
            playedColor: Colors.red,
            bufferedColor: Colors.grey,
            backgroundColor: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
              ),
              IconButton(
                icon: Icon(_isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
                onPressed: () => _toggleFullScreen(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FullScreenVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final String title;

  const FullScreenVideoPlayer({Key? key, required this.videoUrl, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: TourVideoPlayer(videoUrl: videoUrl),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: vrPage(),
  ));
}
