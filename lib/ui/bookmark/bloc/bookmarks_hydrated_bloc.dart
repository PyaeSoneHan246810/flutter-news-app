import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../domain/model/article.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksHydratedBloc
    extends HydratedBloc<BookmarkEvent, BookmarksState> {
  BookmarksHydratedBloc() : super(const BookmarksState()) {
    on<BookmarkFetched>(_onFeteched);
    on<BookmarkAdded>(_onAdded);
    on<BookmarkRemoved>(_onRemoved);
  }

  void _onFeteched(
    BookmarkFetched event,
    Emitter<BookmarksState> emit,
  ) {
    if (state.status == BookmarksStatus.success) return;
    emit(
      state.copyWith(
        bookmarks: state.bookmarks,
        status: BookmarksStatus.success,
      ),
    );
  }

  void _onAdded(
    BookmarkAdded event,
    Emitter<BookmarksState> emit,
  ) {
    emit(
      state.copyWith(
        status: BookmarksStatus.loading,
      ),
    );
    try {
      List<Article> bookmarks = [];
      bookmarks.addAll(state.bookmarks);
      bookmarks.insert(0, event.article);
      emit(
        state.copyWith(
          bookmarks: bookmarks,
          status: BookmarksStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarksStatus.error,
        ),
      );
    }
  }

  void _onRemoved(
    BookmarkRemoved event,
    Emitter<BookmarksState> emit,
  ) {
    emit(
      state.copyWith(
        status: BookmarksStatus.loading,
      ),
    );
    try {
      state.bookmarks.remove(event.article);
      emit(
        state.copyWith(
          bookmarks: state.bookmarks,
          status: BookmarksStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarksStatus.error,
        ),
      );
    }
  }

  @override
  BookmarksState? fromJson(Map<String, dynamic> json) {
    return BookmarksState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BookmarksState state) {
    return state.toJson();
  }
}
