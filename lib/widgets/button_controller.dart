import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonAudioController extends StatelessWidget {
  final bool isFalse;
  final void Function()? onPressed;
  final Duration? positionStream;
  final Duration? durationStream;
  final void Function(Duration)? onSeek;
  const ButtonAudioController(
      {super.key,
      this.onSeek,
      this.isFalse = true,
      required this.onPressed,
      required this.positionStream,
      required this.durationStream});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: IconButton(
              onPressed: onPressed,
              icon: isFalse
                  ? const Icon(Icons.play_arrow, color: Colors.white)
                  : const Icon(Icons.pause_sharp, color: Colors.white),
            ),
          ),
          SizedBox(width: 20.0.w),
          Expanded(
              child: ProgressBar(
                  onSeek: onSeek,
                  progress: positionStream ?? Duration.zero,
                  total: durationStream ?? Duration.zero))
        ],
      ),
    ));
  }
}
