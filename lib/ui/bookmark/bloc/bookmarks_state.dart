part of 'bookmarks_hydrated_bloc.dart';

@immutable
sealed class BookmarksState {}

final class BookmarksInitial extends BookmarksState {}

final class BookmarksLoaded extends BookmarksState {
  final List<Article> bookmarks;
  BookmarksLoaded(this.bookmarks);
}
