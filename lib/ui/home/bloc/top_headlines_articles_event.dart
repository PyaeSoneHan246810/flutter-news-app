part of 'top_headlines_articles_bloc.dart';

@immutable
sealed class TopHeadlinesArticlesEvent {}

final class TopHeadlinesArticlesFetched extends TopHeadlinesArticlesEvent {}
