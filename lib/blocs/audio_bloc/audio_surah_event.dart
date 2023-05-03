part of 'audio_surah_bloc.dart';

abstract class AudioSurahEvent extends Equatable {
  const AudioSurahEvent();

  @override
  List<Object> get props => [];
}

class Start extends AudioSurahEvent {}

class OnPlay extends AudioSurahEvent {
  final Duration positionStream;
  final Duration bufferedPositionStream;
  final Duration durationStream;

  const OnPlay(
      this.positionStream, this.bufferedPositionStream, this.durationStream);

  @override
  List<Object> get props =>
      [positionStream, bufferedPositionStream, durationStream];
}

class Paused extends AudioSurahEvent {}

class Resumed extends AudioSurahEvent {}

class OnSeek extends AudioSurahEvent {
  final Duration position;

  const OnSeek(this.position);

  @override
  List<Object> get props => [position];
}

class Play extends AudioSurahEvent {}
