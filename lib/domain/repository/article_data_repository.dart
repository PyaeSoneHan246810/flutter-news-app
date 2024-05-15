import 'dart:convert';

import '../../utils/constants.dart';
import '../../data/network/article_data_provider.dart';
import '../../utils/secrets.dart';
import '../model/article.dart';

class ArticleDataRepository {
  final ArticleDataProvider articleDataProvider;
  ArticleDataRepository(
    this.articleDataProvider,
  );
  Future<List<Article>> getTopHeadlinesArticles() async {
    try {
      final dataString = await articleDataProvider.getTopHeadlinesArticles(
        newsSources,
        newsApiKey,
      );
      final dataMap = jsonDecode(dataString);
      if (dataMap["status"] != "ok") {
        final errorMessage = dataMap["message"];
        throw errorMessage;
      }
      final List<Article> topHeadlinesArticles = [];
      if (dataMap.containsKey("articles")) {
        for (var articleMap in dataMap["articles"]) {
          final article = Article.fromMap(articleMap);
          if (!article.title.startsWith("[Removed]")) {
            topHeadlinesArticles.add(article);
          }
        }
      }
      return topHeadlinesArticles;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Article>> getArticles() async {
    try {
      final dataString = await articleDataProvider.getArticles(
        newsSources,
        newsApiKey,
      );
      final dataMap = jsonDecode(dataString);
      if (dataMap["status"] != "ok") {
        final errorMessage = dataMap["message"];
        throw errorMessage;
      }
      final List<Article> articles = [];
      if (dataMap.containsKey("articles")) {
        for (var articleMap in dataMap["articles"]) {
          final article = Article.fromMap(articleMap);
          if (!article.title.startsWith("[Removed]")) {
            articles.add(article);
          }
        }
      }
      return articles;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Article>> getArticlesByCategory(String category) async {
    try {
      final dataString = await articleDataProvider.getArticlesByCategory(
        category,
        newsCountry,
        newsApiKey,
      );
      final dataMap = jsonDecode(dataString);
      if (dataMap["status"] != "ok") {
        final errorMessage = dataMap["message"];
        throw errorMessage;
      }
      final List<Article> articles = [];
      if (dataMap.containsKey("articles")) {
        for (var articleMap in dataMap["articles"]) {
          final article = Article.fromMap(articleMap);
          if (!article.title.startsWith("[Removed]")) {
            articles.add(article);
          }
        }
      }
      return articles;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Article>> searchArticlesByQuery(String query) async {
    try {
      final dataString = await articleDataProvider.searchArticlesByQuery(
        query.toLowerCase(),
        newsApiKey,
      );
      final dataMap = jsonDecode(dataString);
      if (dataMap["status"] != "ok") {
        final errorMessage = dataMap["message"];
        throw errorMessage;
      }
      final List<Article> searchArticles = [];
      if (dataMap.containsKey("articles")) {
        for (var articleMap in dataMap["articles"]) {
          final article = Article.fromMap(articleMap);
          if (!article.title.startsWith("[Removed]")) {
            searchArticles.add(article);
          }
        }
      }
      return searchArticles;
    } catch (e) {
      throw e.toString();
    }
  }
}
