import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/network/weather_data_provider.dart';
import '../../domain/repository/weather_repository.dart';
import '../home/bloc/current_weather_bloc.dart';
import '../../domain/repository/bookmarks_repository.dart';
import '../bookmark/bloc/bookmarks_hydrated_bloc.dart';
import '../../data/network/article_data_provider.dart';
import '../../domain/repository/article_data_repository.dart';
import '../search/bloc/search_articles_bloc.dart';
import '../explore/bloc/explore_error_status_bloc.dart';
import '../explore/bloc/category_articles_bloc.dart';
import '../home/bloc/home_error_status_bloc.dart';
import '../home/bloc/articles_bloc.dart';
import '../home/bloc/top_headlines_articles_bloc.dart';
import '../explore/bloc/selected_category_bloc.dart';
import '../nav_host/bloc/navigation_visibility_bloc.dart';
import '../user_settings/bloc/current_theme_bloc.dart';
import '../home/bloc/current_date_time_bloc.dart';
import '../nav_host/bloc/selected_page_bloc.dart';
import '../router/router.dart';

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ArticleDataRepository(ArticleDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => BookmarksRepository(),
        ),
        RepositoryProvider(
          create: (context) => WeatherDataRepository(WeatherDataProvider()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SelectedPageBloc(),
          ),
          BlocProvider(
            create: (context) => NavigationVisibilityBloc(),
          ),
          BlocProvider(
            create: (context) => CurrentDateTimeBloc(),
          ),
          BlocProvider(
            create: (context) => SelectedCategoryBloc(),
          ),
          BlocProvider(
            create: (context) => HomeErrorStatusBloc(),
          ),
          BlocProvider(
            create: (context) => ExploreErrorStatusBloc(),
          ),
          BlocProvider(
            create: (context) => CurrentThemeBloc()..add(CurrentThemeInitial()),
          ),
          BlocProvider(
            create: (context) =>
                TopHeadlinesArticlesBloc(context.read<ArticleDataRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ArticlesBloc(context.read<ArticleDataRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryArticlesBloc(context.read<ArticleDataRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                SearchArticlesBloc(context.read<ArticleDataRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                BookmarksHydratedBloc(context.read<BookmarksRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CurrentWeatherBloc(context.read<WeatherDataRepository>()),
          )
        ],
        child: BlocBuilder<CurrentThemeBloc, CurrentThemeState>(
          builder: (context, currentThemeState) {
            return MaterialApp.router(
              title: "Lask Mobile News App",
              theme: currentThemeState.theme,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
