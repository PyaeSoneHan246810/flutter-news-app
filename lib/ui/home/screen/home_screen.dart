import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/current_weather_bloc.dart';
import '../bloc/home_error_status_bloc.dart';
import '../../shared_widgets/error_retry_message.dart';
import '../bloc/articles_bloc.dart';
import '../../shared_widgets/articles_horizontal_shimmer_effect.dart';
import '../bloc/top_headlines_articles_bloc.dart';
import '../../nav_host/bloc/navigation_visibility_bloc.dart';
import '../widgets/action_text_button.dart';
import '../../shared_widgets/articles_horizontal_list.dart';
import '../../../theme/app_font_styles.dart';
import '../bloc/current_date_time_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;

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

    // get current date time
    context.read<CurrentDateTimeBloc>().add(CurrentDateTimeFetched());

    // get current weather
    context.read<CurrentWeatherBloc>().add(CurrentWeatherFetched());

    // get top headlines articles
    context.read<TopHeadlinesArticlesBloc>().add(TopHeadlinesArticlesFetched());

    // get articles
    context.read<ArticlesBloc>().add(ArticlesFetched());
  }

  @override
  Widget build(BuildContext context) {
    final homeErrorStatusBloc = BlocProvider.of<HomeErrorStatusBloc>(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 28,
                top: 8 + MediaQuery.of(context).padding.top,
                right: 28,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<CurrentDateTimeBloc, CurrentDateTimeState>(
                    builder: (context, currentDateTimeState) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentDateTimeState.greetingMessage,
                              style: AppFontStyles.body2Regular.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${currentDateTimeState.dayOfWeek} ${currentDateTimeState.formattedDate}",
                              style: AppFontStyles.headline5.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                    builder: (context, state) {
                      if (state is! CurrentWeatherSuccess) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        );
                      }
                      final currentWeatherIcon =
                          "https://openweathermap.org/img/wn/${state.currentWeather.icon}@2x.png";
                      final currentWeather = state.currentWeather.weather;
                      final currentTemperature =
                          (state.currentWeather.temperature - 273.15).round();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            currentWeatherIcon,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentWeather,
                                style: AppFontStyles.body2Regular.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "$currentTemperature°C",
                                style: AppFontStyles.body2Regular.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocConsumer<HomeErrorStatusBloc, bool>(
              listener: (context, hasError) {
                if (hasError) {
                  context
                      .read<NavigationVisibilityBloc>()
                      .add(NavigationVisibilityChanged(isVisible: true));
                }
              },
              builder: (context, hasError) {
                return Expanded(
                  child: hasError
                      ? Center(
                          child: ErrorRetryMessage(
                            onRetry: () {
                              homeErrorStatusBloc
                                  .add(HomeErrorStatusChanged(hasError: false));
                              context
                                  .read<TopHeadlinesArticlesBloc>()
                                  .add(TopHeadlinesArticlesFetched());
                              context
                                  .read<ArticlesBloc>()
                                  .add(ArticlesFetched());
                              context
                                  .read<CurrentWeatherBloc>()
                                  .add(CurrentWeatherFetched());
                            },
                          ),
                        )
                      : SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              BlocConsumer<TopHeadlinesArticlesBloc,
                                  TopHeadlinesArticlesState>(
                                listener: (context, state) {
                                  if (state is TopHeadlinesArticlesFailure) {
                                    homeErrorStatusBloc.add(
                                        HomeErrorStatusChanged(hasError: true));
                                  }
                                  if (state is TopHeadlinesArticlesSuccess) {
                                    homeErrorStatusBloc.add(
                                        HomeErrorStatusChanged(
                                            hasError: false));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is! TopHeadlinesArticlesSuccess) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      child:
                                          const ArticlesHorizontalShimmerEffect(),
                                    );
                                  }
                                  final topHeadlinesArticles =
                                      state.topHeadlinesArticles;
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: ArticlesHorizontalList(
                                      articles: topHeadlinesArticles,
                                      articlesCount: 10,
                                      articleType: "HeadlineArticle",
                                      onArticleTap: (article, heroTag) {
                                        context.pushNamed(
                                          "/article",
                                          extra: article,
                                          pathParameters: {
                                            "heroTag": heroTag,
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Just For You",
                                      style: AppFontStyles.headline4.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                    ActionTextButton(
                                      onPressed: () {
                                        context.pushNamed("/moreArticles");
                                      },
                                      text: "See more",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              BlocConsumer<ArticlesBloc, ArticlesState>(
                                listener: (context, state) {
                                  if (state is ArticlesFailure) {
                                    homeErrorStatusBloc.add(
                                        HomeErrorStatusChanged(hasError: true));
                                  }

                                  if (state is ArticlesSuccess) {
                                    homeErrorStatusBloc.add(
                                        HomeErrorStatusChanged(
                                            hasError: false));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is! ArticlesSuccess) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      child:
                                          const ArticlesHorizontalShimmerEffect(),
                                    );
                                  }
                                  final articles = state.articles;
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: ArticlesHorizontalList(
                                      articles: articles,
                                      articlesCount: 20,
                                      articleType: "SuggestedArticle",
                                      onArticleTap: (article, heroTag) {
                                        context.pushNamed(
                                          "/article",
                                          extra: article,
                                          pathParameters: {
                                            "heroTag": heroTag,
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
