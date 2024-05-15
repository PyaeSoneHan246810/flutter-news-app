part of 'articles_bloc.dart';

@immutable
sealed class ArticlesEvent {}

final class ArticlesFetched extends ArticlesEvent {}
