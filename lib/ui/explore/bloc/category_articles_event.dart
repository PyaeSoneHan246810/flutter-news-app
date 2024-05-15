part of 'category_articles_bloc.dart';

@immutable
sealed class CategoryArticlesEvent {}

final class CategoryArticlesFetched extends CategoryArticlesEvent {
  final String category;
  CategoryArticlesFetched({required this.category});
}
