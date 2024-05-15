part of 'category_articles_bloc.dart';

@immutable
sealed class CategoryArticlesState {}

final class CategoryArticlesInitial extends CategoryArticlesState {}

final class CategoryArticlesLoading extends CategoryArticlesState {}

final class CategoryArticlesFailure extends CategoryArticlesState {
  final String errorMessage;
  CategoryArticlesFailure(this.errorMessage);
}

final class CategoryArticlesSuccess extends CategoryArticlesState {
  final List<Article> articles;
  CategoryArticlesSuccess(this.articles);
}
