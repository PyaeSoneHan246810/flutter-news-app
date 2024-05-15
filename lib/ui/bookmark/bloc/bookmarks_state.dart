part of 'bookmarks_hydrated_bloc.dart';

enum BookmarksStatus {
  initial,
  loading,
  success,
  error,
}

class BookmarksState extends Equatable {
  final List<Article> bookmarks;
  final BookmarksStatus status;
  const BookmarksState({
    this.bookmarks = const <Article>[],
    this.status = BookmarksStatus.initial,
  });

  BookmarksState copyWith({
    List<Article>? bookmarks,
    BookmarksStatus? status,
  }) {
    return BookmarksState(
      bookmarks: bookmarks ?? this.bookmarks,
      status: status ?? this.status,
    );
  }

  @override
  factory BookmarksState.fromJson(Map<String, dynamic> json) {
    try {
      final bookmarks = (json['bookmarks'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList();
      return BookmarksState(
        bookmarks: bookmarks,
        status: BookmarksStatus.values
            .firstWhere((element) => element.toString() == json['status']),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'bookmarks': bookmarks,
      'status': status.toString(),
    };
  }

  @override
  List<Object?> get props => [bookmarks, status];
}
