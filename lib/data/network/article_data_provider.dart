import 'package:http/http.dart' as http;

class ArticleDataProvider {
  Future<String> getTopHeadlinesArticles(String sources, String apiKey) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=$sources&apiKey=$apiKey",
        ),
      );
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> getArticles(String sources, String apiKey) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/everything?sources=$sources&apiKey=$apiKey"),
      );
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> getArticlesByCategory(
    String category,
    String country,
    String apiKey,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?category=$category&country=$country&apiKey=$apiKey"),
      );
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> searchArticlesByQuery(
    String query,
    String apiKey,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey"),
      );
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
