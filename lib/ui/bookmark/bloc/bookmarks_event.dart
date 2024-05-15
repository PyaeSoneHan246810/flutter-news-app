part of 'bookmarks_hydrated_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class BookmarkFetched extends BookmarkEvent {}

class BookmarkAdded extends BookmarkEvent {
  final Article article;
  const BookmarkAdded(this.article);

  @override
  List<Object?> get props => [article];
}

class BookmarkRemoved extends BookmarkEvent {
  final Article article;
  const BookmarkRemoved(this.article);

  @override
  List<Object?> get props => [article];
}
