import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoplayerPage extends StatefulWidget {
  final String url;
  const VideoplayerPage({super.key, required this.url});

  @override
  State<VideoplayerPage> createState() => _VideoplayerPageState();
}

class _VideoplayerPageState extends State<VideoplayerPage> {
  VideoPlayerController? controller;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    log(Uri.parse(widget.url).toString());
    controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        controller!.play();
      }).catchError((error) {
        log("Error initializing video: $error");
      });

    chewieController = ChewieController(
      videoPlayerController: controller!,
      autoPlay: true,
      looping: true,
      allowFullScreen: true,
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller!.value.isInitialized
        ? chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: Chewie(controller: chewieController!),
              )
            : const Center(child: CircularProgressIndicator())
        : const Center(child: CircularProgressIndicator());
  }
}
