part of 'search_articles_bloc.dart';

@immutable
sealed class SearchArticlesState {}

final class SearchArticlesInitial extends SearchArticlesState {}

final class SearchArticlesLoading extends SearchArticlesState {}

final class SearchArticlesFailure extends SearchArticlesState {
  final String errorMessage;
  SearchArticlesFailure(this.errorMessage);
}

final class SearchArticlesSuccess extends SearchArticlesState {
  final List<Article> searchArticles;
  SearchArticlesSuccess(this.searchArticles);
}
