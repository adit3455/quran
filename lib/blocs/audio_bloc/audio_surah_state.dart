part of 'audio_surah_bloc.dart';

abstract class AudioSurahState extends Equatable {
  const AudioSurahState();

  @override
  List<Object> get props => [];
}

class AudioSurahError extends AudioSurahState {
  final String e;

  const AudioSurahError(this.e);

  @override
  List<Object> get props => [e];
}

class AudioSurahInitial extends AudioSurahState {}

class AudioSurahPlayed extends AudioSurahState {
  final Duration positionStream;
  final Duration bufferedPositionStream;
  final Duration durationStream;

  const AudioSurahPlayed(
      this.positionStream, this.bufferedPositionStream, this.durationStream);

  @override
  List<Object> get props =>
      [positionStream, bufferedPositionStream, durationStream];
}

class AudioSurahCompleted extends AudioSurahState {
  final Duration duration;

  const AudioSurahCompleted(this.duration);
  @override
  List<Object> get props => [duration];
}

class AudioSurahPaused extends AudioSurahState {
  final Duration positionStream;
  final Duration bufferedPositionStream;
  final Duration durationStream;

  const AudioSurahPaused(
      this.positionStream, this.bufferedPositionStream, this.durationStream);

  @override
  List<Object> get props =>
      [positionStream, bufferedPositionStream, durationStream];
}

class AudioSurahLoading extends AudioSurahState {}
