part of 'top_headlines_articles_bloc.dart';

@immutable
sealed class TopHeadlinesArticlesState {}

final class TopHeadlinesArticlesInitial extends TopHeadlinesArticlesState {}

final class TopHeadlinesArticlesLoading extends TopHeadlinesArticlesState {}

final class TopHeadlinesArticlesFailure extends TopHeadlinesArticlesState {
  final String errorMessage;
  TopHeadlinesArticlesFailure(this.errorMessage);
}

final class TopHeadlinesArticlesSuccess extends TopHeadlinesArticlesState {
  final List<Article> topHeadlinesArticles;
  TopHeadlinesArticlesSuccess(this.topHeadlinesArticles);
}
