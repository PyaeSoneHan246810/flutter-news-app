import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../user_settings/bloc/current_theme_bloc.dart';
import '../bloc/explore_error_status_bloc.dart';
import '../widgets/category_chip_item.dart';
import '../../shared_widgets/error_retry_message.dart';
import '../bloc/category_articles_bloc.dart';
import '../../shared_widgets/articles_vertical_shimmer_effect.dart';
import '../bloc/selected_category_bloc.dart';
import '../../nav_host/bloc/navigation_visibility_bloc.dart';
import '../../shared_widgets/large_title_top_bar.dart';
import '../../shared_widgets/articles_vertical_list.dart';
import '../../shared_widgets/article_card_verticle.dart';
import '../../shared_widgets/action_icon_button.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final ScrollController _scrollController;

  final List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];

  @override
  void initState() {
    super.initState();
    // initialize scroll controller
    _scrollController = ScrollController();

    // add listener to scroll controller
    _scrollController.addListener(() {
      final scrollDirection = _scrollController.position.userScrollDirection;
      if (scrollDirection == ScrollDirection.forward) {
        context
            .read<NavigationVisibilityBloc>()
            .add(NavigationVisibilityChanged(isVisible: true));
      } else {
        context
            .read<NavigationVisibilityBloc>()
            .add(NavigationVisibilityChanged(isVisible: false));
      }
    });

    // get articles by category
    _getArticlesByCategory(
      categories[context.read<SelectedCategoryBloc>().state],
    );
  }

  void _getArticlesByCategory(String category) {
    context.read<CategoryArticlesBloc>().add(
          CategoryArticlesFetched(category: category),
        );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategoryBloc = BlocProvider.of<SelectedCategoryBloc>(context);
    final exploreErrorStatusBloc =
        BlocProvider.of<ExploreErrorStatusBloc>(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            LargeTitleTopBar(
              title: "Explore",
              actions: [
                ActionIconButton(
                  iconData: MaterialSymbols.search_outlined,
                  size: 24,
                  onPressed: () {
                    context.pushNamed("/search");
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 42,
                      child: BlocConsumer<SelectedCategoryBloc, int>(
                        listener: (context, selectedCategoryIndex) {
                          exploreErrorStatusBloc.add(
                            ExploreErrorStatusChanged(
                              hasError: false,
                            ),
                          );
                          final category = categories[selectedCategoryIndex];
                          _getArticlesByCategory(category);
                        },
                        builder: (context, selectedCategoryIndex) {
                          return BlocBuilder<CurrentThemeBloc,
                              CurrentThemeState>(
                            builder: (context, currentThemeState) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  final isFirstItem = index == 0;
                                  final isLastItem =
                                      index == categories.length - 1;
                                  final isCategorySelected =
                                      index == selectedCategoryIndex;
                                  final selectedBackgroundColor =
                                      currentThemeState.isDarkThemeEnabled
                                          ? const Color(0xff1A1A1A)
                                          : const Color(0xffE9EEFA);
                                  final unSelectedBackgroundColor =
                                      currentThemeState.isDarkThemeEnabled
                                          ? const Color(0xff0D0D0D)
                                          : const Color(0xffFFFFFF);
                                  final backgroundColor = isCategorySelected
                                      ? selectedBackgroundColor
                                      : unSelectedBackgroundColor;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: isFirstItem ? 28 : 8,
                                      right: isLastItem ? 28 : 0,
                                    ),
                                    child: CategoryChipItem(
                                      onTap: () {
                                        selectedCategoryBloc.add(
                                          SelectedCategoryChanged(
                                            selectedCategoryIndex: index,
                                          ),
                                        );
                                      },
                                      category: category,
                                      backgroundColor: backgroundColor,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<ExploreErrorStatusBloc, bool>(
                      listener: (context, hasError) {
                        if (hasError) {
                          context.read<NavigationVisibilityBloc>().add(
                              NavigationVisibilityChanged(isVisible: true));
                        }
                      },
                      builder: (context, hasError) {
                        return hasError
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ErrorRetryMessage(
                                    onRetry: () {
                                      exploreErrorStatusBloc.add(
                                        ExploreErrorStatusChanged(
                                          hasError: false,
                                        ),
                                      );
                                      final category = categories[context
                                          .read<SelectedCategoryBloc>()
                                          .state];
                                      _getArticlesByCategory(category);
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 28,
                                      right: 28,
                                    ),
                                    child: BlocConsumer<CategoryArticlesBloc,
                                        CategoryArticlesState>(
                                      listener: (context, state) {
                                        if (state is CategoryArticlesFailure) {
                                          exploreErrorStatusBloc.add(
                                            ExploreErrorStatusChanged(
                                              hasError: true,
                                            ),
                                          );
                                        }
                                        if (state is CategoryArticlesSuccess) {
                                          exploreErrorStatusBloc.add(
                                            ExploreErrorStatusChanged(
                                              hasError: false,
                                            ),
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is! CategoryArticlesSuccess) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.40,
                                            child: Center(
                                              child: Lottie.asset(
                                                "assets/animations/loading_anim.json",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                        final article = state.articles[0];
                                        return ArticleCardVertical(
                                          onArticleTap: () {
                                            context.pushNamed(
                                              "/article",
                                              extra: article,
                                              pathParameters: {
                                                "heroTag":
                                                    "${article.urlToImage}/ExploreHeroArticle",
                                              },
                                            );
                                          },
                                          cardWidth:
                                              MediaQuery.of(context).size.width,
                                          cardHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.40,
                                          imageWidth:
                                              MediaQuery.of(context).size.width,
                                          imageHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                          urltoImage: article.urlToImage,
                                          title: article.title,
                                          sourceName: article.source.name,
                                          heroImageTag:
                                              "${article.urlToImage}/ExploreHeroArticle",
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    child: BlocConsumer<CategoryArticlesBloc,
                                        CategoryArticlesState>(
                                      listener: (context, state) {
                                        if (state is CategoryArticlesFailure) {
                                          exploreErrorStatusBloc.add(
                                            ExploreErrorStatusChanged(
                                                hasError: true),
                                          );
                                        }
                                        if (state is CategoryArticlesSuccess) {
                                          exploreErrorStatusBloc.add(
                                            ExploreErrorStatusChanged(
                                                hasError: false),
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is! CategoryArticlesSuccess) {
                                          return const ArticlesVerticalShimmerEffect(
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics());
                                        }
                                        return ArticlesVerticalList(
                                          scrollPhysics:
                                              const NeverScrollableScrollPhysics(),
                                          articles: state.articles.sublist(1),
                                          articleType: "ExploreArticles",
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
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
