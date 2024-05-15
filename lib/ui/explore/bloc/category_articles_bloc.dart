import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/article_data_repository.dart';
import '../../../domain/model/article.dart';

part 'category_articles_event.dart';
part 'category_articles_state.dart';

class CategoryArticlesBloc
    extends Bloc<CategoryArticlesEvent, CategoryArticlesState> {
  final ArticleDataRepository articleDataRepository;
  CategoryArticlesBloc(this.articleDataRepository)
      : super(CategoryArticlesInitial()) {
    on<CategoryArticlesFetched>(_getArticlesByCategory);
  }

  void _getArticlesByCategory(
    CategoryArticlesFetched event,
    Emitter<CategoryArticlesState> emit,
  ) async {
    emit(CategoryArticlesLoading());
    try {
      final articles =
          await articleDataRepository.getArticlesByCategory(event.category);
      emit(CategoryArticlesSuccess(articles));
    } catch (e) {
      emit(CategoryArticlesFailure(e.toString()));
    }
  }
}
