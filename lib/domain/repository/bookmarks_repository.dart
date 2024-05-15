import '../model/article.dart';

class BookmarksRepository {
  List<Article> bookmarks = [];

  List<Article> addBookmark(Article article) {
    bookmarks.add(article);
    return bookmarks;
  }

  List<Article> removeBookmark(Article article) {
    bookmarks.remove(article);
    return bookmarks;
  }
}
