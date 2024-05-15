import 'package:flutter/material.dart';
import '../../domain/model/article.dart';
import 'article_card_verticle.dart';

class ArticlesHorizontalList extends StatelessWidget {
  const ArticlesHorizontalList({
    super.key,
    required this.articles,
    required this.articlesCount,
    required this.articleType,
    required this.onArticleTap,
  });
  final List<Article> articles;
  final int articlesCount;
  final String articleType;
  final Function(Article, String) onArticleTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: articlesCount,
      itemBuilder: (context, index) {
        final article = articles[index];
        final isFirstItem = index == 0;
        final isLastItem = index == articlesCount - 1;
        final heroTag = "${article.urlToImage}/$articleType/$index";
        final urlToImage = article.urlToImage;
        final title = article.title;
        final sourceName = article.source.name;
        return Padding(
          padding: EdgeInsets.only(
            left: isFirstItem ? 28 : 20,
            right: isLastItem ? 28 : 0,
          ),
          child: ArticleCardVertical(
            onArticleTap: () {
              onArticleTap(article, heroTag);
            },
            cardWidth: MediaQuery.of(context).size.width * 0.65,
            cardHeight: MediaQuery.of(context).size.height * 0.45,
            imageWidth: MediaQuery.of(context).size.width * 0.65,
            imageHeight: MediaQuery.of(context).size.width * 0.65,
            urltoImage: urlToImage,
            title: title,
            sourceName: sourceName,
            heroImageTag: heroTag,
          ),
        );
      },
    );
  }
}
