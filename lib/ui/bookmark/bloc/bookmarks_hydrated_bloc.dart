import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../domain/repository/bookmarks_repository.dart';
import '../../../domain/model/article.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksHydratedBloc
    extends HydratedBloc<BookmarksEvent, BookmarksState> {
  final BookmarksRepository bookmarksRepository;
  BookmarksHydratedBloc(this.bookmarksRepository) : super(BookmarksInitial()) {
    on<BookmarksFetched>((event, emit) {
      emit(BookmarksLoaded(bookmarksRepository.bookmarks));
    });
    on<BookmarkAdded>((event, emit) {
      emit(BookmarksLoaded(bookmarksRepository.addBookmark(event.article)));
    });
    on<BookmarkRemoved>((event, emit) {
      emit(BookmarksLoaded(bookmarksRepository.removeBookmark(event.article)));
    });
  }

  @override
  BookmarksState? fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
      final bookmarks = (json['data'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList();
      return BookmarksLoaded(bookmarks);
    }
    return BookmarksInitial();
  }

  @override
  Map<String, dynamic>? toJson(BookmarksState state) {
    if (state is BookmarksLoaded) {
      final bookmarks = state.bookmarks.map((e) => e.toJson()).toList();
      return {'data': bookmarks};
    }
    return {'data': []};
  }
}
