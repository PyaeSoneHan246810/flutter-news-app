part of 'articles_bloc.dart';

@immutable
sealed class ArticlesState {}

final class ArticlesInitial extends ArticlesState {}

final class ArticlesLoading extends ArticlesState {}

final class ArticlesFailure extends ArticlesState {
  final String errorMessage;
  ArticlesFailure(this.errorMessage);
}

final class ArticlesSuccess extends ArticlesState {
  final List<Article> articles;
  ArticlesSuccess(this.articles);
}
