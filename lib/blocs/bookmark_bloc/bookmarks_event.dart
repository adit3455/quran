part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class StartBookmarks extends BookmarksEvent {}

class AddBookmarks extends BookmarksEvent {
  final Ayat ayat;

  const AddBookmarks({required this.ayat});
  @override
  List<Object> get props => [ayat];
}

class RemoveBookmarks extends BookmarksEvent {
  final int index;
  final Ayat ayat;

  const RemoveBookmarks({required this.ayat, required this.index});
  @override
  List<Object> get props => [ayat];
}
