import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:go_router/go_router.dart';
import '../../user_settings/bloc/current_theme_bloc.dart';
import '../../shared_widgets/toast_bar.dart';
import '../bloc/search_articles_bloc.dart';
import '../../shared_widgets/articles_vertical_list.dart';
import '../widgets/search_state_message.dart';
import '../widgets/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchQueryTextEditingController;

  @override
  void initState() {
    super.initState();
    final searchArticlesBloc = BlocProvider.of<SearchArticlesBloc>(context);
    searchArticlesBloc.add(SearchArticlesResetState());
    _searchQueryTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _searchQueryTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SearchTextField(
                  searchQueryTextEditingController:
                      _searchQueryTextEditingController,
                  onSubmitted: (searchQuery) {
                    if (searchQuery.isNotEmpty) {
                      context
                          .read<SearchArticlesBloc>()
                          .add(SearchArticlesFetched(searchQuery));
                    } else {
                      toastBar(
                        "Please enter the information",
                        MaterialSymbols.info_outlined,
                      ).show(context);
                    }
                  },
                ),
              ),
              BlocBuilder<CurrentThemeBloc, CurrentThemeState>(
                builder: (context, currentThemeState) {
                  return Expanded(
                    child: BlocBuilder<SearchArticlesBloc, SearchArticlesState>(
                      builder: (context, state) {
                        if (state is SearchArticlesInitial) {
                          return SearchStateMessage(
                            stateLabel: "Search Initial State",
                            animation: currentThemeState.isDarkThemeEnabled
                                ? "assets/animations/search_initial_dark_anim.json"
                                : "assets/animations/search_initial_anim.json",
                            message: "Search for articles",
                          );
                        }
                        if (state is SearchArticlesFailure) {
                          final searchQuery =
                              _searchQueryTextEditingController.text.trim();
                          return SearchStateMessage(
                            stateLabel: "Search Error State",
                            animation: currentThemeState.isDarkThemeEnabled
                                ? "assets/animations/search_error_dark_anim.json"
                                : "assets/animations/search_error_anim.json",
                            message: "Coundn't search for \"$searchQuery\"",
                          );
                        }
                        if (state is! SearchArticlesSuccess) {
                          final searchQuery =
                              _searchQueryTextEditingController.text.trim();
                          return SearchStateMessage(
                            stateLabel: "Search Loading State",
                            animation:
                                "assets/animations/search_loading_anim.json",
                            message: "Searching for \"$searchQuery\"",
                          );
                        }
                        final searchArticles = state.searchArticles;
                        return (searchArticles.isEmpty)
                            ? SearchStateMessage(
                                stateLabel: "Search Empty State",
                                animation: currentThemeState.isDarkThemeEnabled
                                    ? "assets/animations/search_empty_dark_anim.json"
                                    : "assets/animations/search_empty_anim.json",
                                message: "No article found",
                              )
                            : ArticlesVerticalList(
                                scrollPhysics:
                                    const AlwaysScrollableScrollPhysics(),
                                articles: state.searchArticles,
                                articleType: "SearchArticle",
                                onArticleTap: (article, heroTag) {
                                  context.pushNamed(
                                    "/article",
                                    extra: article,
                                    pathParameters: {
                                      "heroTag": heroTag,
                                    },
                                  );
                                },
                              );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
