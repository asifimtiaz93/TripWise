// lib/pages/navpages/vr_page.dart

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  static const List<String> _chipLabels = [
    'Cox\'s Bazar',
    'Sylhet',
    'Chattogram',
    'Rangpur',
  ];

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
