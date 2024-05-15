import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/article.dart';
import '../../../domain/repository/article_data_repository.dart';

part 'top_headlines_articles_event.dart';
part 'top_headlines_articles_state.dart';

class TopHeadlinesArticlesBloc
    extends Bloc<TopHeadlinesArticlesEvent, TopHeadlinesArticlesState> {
  final ArticleDataRepository articleDataRepository;
  TopHeadlinesArticlesBloc(this.articleDataRepository)
      : super(TopHeadlinesArticlesInitial()) {
    on<TopHeadlinesArticlesFetched>(_getTopHeadlinesArticles);
  }

  void _getTopHeadlinesArticles(
    TopHeadlinesArticlesFetched event,
    Emitter<TopHeadlinesArticlesState> emit,
  ) async {
    emit(TopHeadlinesArticlesLoading());
    try {
      final topHeadlinesArticles =
          await articleDataRepository.getTopHeadlinesArticles();
      emit(TopHeadlinesArticlesSuccess(topHeadlinesArticles));
    } catch (e) {
      emit(TopHeadlinesArticlesFailure(e.toString()));
    }
  }
}
