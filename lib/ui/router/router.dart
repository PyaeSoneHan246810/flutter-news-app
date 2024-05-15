import 'package:go_router/go_router.dart';
import '../../domain/model/article.dart';
import '../search/screen/search_screen.dart';
import '../more_articles/screen/more_articles_screen.dart';
import '../article/screen/web_view_screen.dart';
import '../article/screen/article_screen.dart';
import '../nav_host/screen/nav_host_screen.dart';
import '../intro/screen/intro_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/intro",
  routes: <RouteBase>[
    GoRoute(
      name: "/intro",
      path: "/intro",
      builder: (context, state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      name: "/navHost",
      path: "/navHost",
      builder: (context, state) {
        return const NavHostScreen();
      },
    ),
    GoRoute(
      name: "/article",
      path: "/article/:heroTag",
      builder: (context, state) {
        final Article article = state.extra as Article;
        final String heroTag = state.pathParameters["heroTag"]!;
        return ArticleScreen(
          article: article,
          heroTag: heroTag,
        );
      },
    ),
    GoRoute(
      name: "/webView",
      path: "/webView/:url",
      builder: (context, state) {
        final String articleUrl = state.pathParameters["url"] ?? "";
        return WebViewScreen(
          articleUrl: articleUrl,
        );
      },
    ),
    GoRoute(
      name: "/moreArticles",
      path: "/moreArticles",
      builder: (context, state) {
        return const MoreArticlesScreen();
      },
    ),
    GoRoute(
      name: "/search",
      path: "/search",
      builder: (context, state) {
        return const SearchScreen();
      },
    )
  ],
);
