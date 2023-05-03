import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/services/localstoragerepo.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  LocalStorageRepository localStorageRepository;
  BookmarksBloc({required this.localStorageRepository})
      : super(BookmarksLoading()) {
    on<StartBookmarks>(_onStartBookmarks);
    on<AddBookmarks>(_onAddBookmarks);
    on<RemoveBookmarks>(_onRemoveBookmarks);
  }

  void _onStartBookmarks(
      StartBookmarks event, Emitter<BookmarksState> emit) async {
    emit(BookmarksLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      Box box = await localStorageRepository.openBox();
      List<Ayat> ayats = localStorageRepository.getBookmarks(box);
      emit(BookmarksLoaded(ayat: ayats));
    } catch (e) {
      emit(BookmarksError(error: e.toString()));
    }
  }

  void _onAddBookmarks(AddBookmarks event, Emitter<BookmarksState> emit) async {
    try {
      final state = this.state;
      if (state is BookmarksLoaded) {
        localStorageRepository.addAyatToBookmarks(event.ayat);
        emit(BookmarksLoaded(ayat: List.from(state.ayat)..add(event.ayat)));
      }
    } catch (e) {
      emit(BookmarksError(error: e.toString()));
    }
  }

  void _onRemoveBookmarks(
      RemoveBookmarks event, Emitter<BookmarksState> emit) async {
    try {
      final state = this.state;
      if (state is BookmarksLoaded) {
        localStorageRepository.removeAyatToBookmarks(event.ayat, event.index);
        emit(BookmarksLoaded(ayat: List.from(state.ayat)..remove(event.ayat)));
      }
    } catch (e) {
      emit(BookmarksError(error: e.toString()));
    }
  }
}
