part of 'bookmarks_hydrated_bloc.dart';

@immutable
sealed class BookmarksEvent {}

final class BookmarksFetched extends BookmarksEvent {}

final class BookmarkAdded extends BookmarksEvent {
  final Article article;
  BookmarkAdded(this.article);
}

final class BookmarkRemoved extends BookmarksEvent {
  final Article article;
  BookmarkRemoved(this.article);
}
