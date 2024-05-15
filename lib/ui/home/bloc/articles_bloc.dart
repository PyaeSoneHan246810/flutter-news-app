import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/article.dart';
import '../../../domain/repository/article_data_repository.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticleDataRepository articleDataRepository;
  ArticlesBloc(this.articleDataRepository) : super(ArticlesInitial()) {
    on<ArticlesFetched>(_getArticles);
  }

  void _getArticles(
    ArticlesFetched event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoading());
    try {
      final articles = await articleDataRepository.getArticles();
      emit(ArticlesSuccess(articles));
    } catch (e) {
      emit(ArticlesFailure(e.toString()));
    }
  }
}
