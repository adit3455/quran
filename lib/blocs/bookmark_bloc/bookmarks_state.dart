// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object> get props => [];
}

class BookmarksLoading extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {
  final List<Ayat> ayat;
  const BookmarksLoaded({this.ayat = const <Ayat>[]});

  @override
  List<Object> get props => [ayat];
}

class BookmarksError extends BookmarksState {
  final String error;

  const BookmarksError({required this.error});

  @override
  List<Object> get props => [error];
}
