import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerService {
  Stream<PositionData> positionDataStream(AudioPlayer audioPlayer) {
    return Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferedStream, duration) =>
            PositionData(position, bufferedStream, duration ?? Duration.zero));
  }

  positionDataStreamValue(AudioPlayer audioPlayer, String source) async {
    await init(audioPlayer, source);

    audioPlayer.duration;
  }

  Future<void> init(AudioPlayer audioPlayer, String source) async {
    await audioPlayer.setUrl(source);
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  PositionData(this.position, this.bufferedPosition, this.duration);
}
