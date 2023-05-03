import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/repositories/export_repo.dart';

part 'search_surah_event.dart';
part 'search_surah_state.dart';

class SearchSurahBloc extends Bloc<SearchSurahEvent, SearchSurahState> {
  final QuranSurah _quranSurah;
  SearchSurahBloc(this._quranSurah) : super(SearchSurahInitial()) {
    on<SurahSearched>((event, emit) async {
      try {
        List<QuranSurahModel> surahs =
            await _quranSurah.getAllSurahSearch(event.text);
        emit(SearhSurahLoading());
        await Future.delayed(const Duration(seconds: 1));
        if (surahs.isEmpty) {
          emit(SearchNotFoundState());
        } else {
          emit(SearhStateLoaded(surahs));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
