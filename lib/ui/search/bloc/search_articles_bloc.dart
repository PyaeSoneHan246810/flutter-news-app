import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/article_data_repository.dart';
import '../../../domain/model/article.dart';

part 'search_articles_event.dart';
part 'search_articles_state.dart';

class SearchArticlesBloc
    extends Bloc<SearchArticlesEvent, SearchArticlesState> {
  final ArticleDataRepository articleDataRepository;
  SearchArticlesBloc(this.articleDataRepository)
      : super(SearchArticlesInitial()) {
    on<SearchArticlesFetched>(_searchArticlesByQuery);
    on<SearchArticlesResetState>(
      (event, emit) {
        emit(SearchArticlesInitial());
      },
    );
  }

  void _searchArticlesByQuery(
    SearchArticlesFetched event,
    Emitter<SearchArticlesState> emit,
  ) async {
    emit(SearchArticlesLoading());
    try {
      final searchArticles =
          await articleDataRepository.searchArticlesByQuery(event.searchQuery);
      emit(SearchArticlesSuccess(searchArticles));
    } catch (e) {
      emit(SearchArticlesFailure(e.toString()));
    }
  }
}
