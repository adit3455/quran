import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/services/audioplay_service.dart';

part 'audio_surah_event.dart';
part 'audio_surah_state.dart';

class AudioSurahBloc extends Bloc<AudioSurahEvent, AudioSurahState> {
  final AudioPlayerService _audioPlayerService;
  final AudioPlayer _audioPlayer;
  final String _source;

  AudioSurahBloc(this._audioPlayerService, this._audioPlayer, this._source)
      : super(AudioSurahLoading()) {
    on<Start>((event, emit) async {
      try {
        await _audioPlayerService.init(_audioPlayer, _source);
      } catch (e) {
        emit(AudioSurahError(e.toString()));
      }

      await _audioPlayer.stop();
      _audioPlayerService.positionDataStream(_audioPlayer).listen((e) {
        add(OnPlay(e.position, e.bufferedPosition, e.duration));
      });
    });

    on<OnPlay>((event, emit) async {
      emit(event.positionStream.inSeconds > 0
          ? AudioSurahPlayed(event.positionStream, event.bufferedPositionStream,
              event.durationStream)
          : AudioSurahCompleted(event.durationStream));
    });

    on<Play>((event, emit) async {
      await _audioPlayer.play();
    });

    on<Paused>((event, emit) async {
      final statePlayed = (state as AudioSurahPlayed);

      await _audioPlayer.pause();

      emit(AudioSurahPaused(statePlayed.positionStream,
          statePlayed.bufferedPositionStream, statePlayed.durationStream));
    });

    on<OnSeek>((event, emit) async {
      final statePlayed = (state as AudioSurahPlayed);
      await _audioPlayer.seek(event.position);

      emit(AudioSurahPlayed(event.position, statePlayed.bufferedPositionStream,
          statePlayed.durationStream));
    });

    on<Resumed>((event, emit) {
      final statePlayed = (state as AudioSurahPaused);

      _audioPlayer.play();

      emit(AudioSurahPlayed(statePlayed.positionStream,
          statePlayed.bufferedPositionStream, statePlayed.durationStream));
    });
  }
}
