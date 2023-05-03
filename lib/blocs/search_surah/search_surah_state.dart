part of 'search_surah_bloc.dart';

abstract class SearchSurahState extends Equatable {
  const SearchSurahState();

  @override
  List<Object> get props => [];
}

class SearchSurahInitial extends SearchSurahState {}

class SearhSurahLoading extends SearchSurahState {}

class SearhStateLoaded extends SearchSurahState {
  final List<QuranSurahModel> surahs;
  const SearhStateLoaded(this.surahs);
  @override
  List<Object> get props => [];
}

class SearchNotFoundState extends SearchSurahState {}

class SearchError extends SearchSurahState {
  final String error;

  const SearchError(this.error);
  @override
  List<Object> get props => [error];
}
