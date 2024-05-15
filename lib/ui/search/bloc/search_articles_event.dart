part of 'search_articles_bloc.dart';

@immutable
sealed class SearchArticlesEvent {}

final class SearchArticlesFetched extends SearchArticlesEvent {
  final String searchQuery;
  SearchArticlesFetched(this.searchQuery);
}

final class SearchArticlesResetState extends SearchArticlesEvent {}
