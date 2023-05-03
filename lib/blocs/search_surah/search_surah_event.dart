part of 'search_surah_bloc.dart';

abstract class SearchSurahEvent extends Equatable {
  const SearchSurahEvent();

  @override
  List<Object> get props => [];
}

class SurahSearched extends SearchSurahEvent {
  final String text;

  const SurahSearched(this.text);

  @override
  List<Object> get props => [text];
}
