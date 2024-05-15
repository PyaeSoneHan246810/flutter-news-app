import 'package:flutter/material.dart';
import 'article_card_horizontal.dart';
import '../../domain/model/article.dart';

class ArticlesVerticalList extends StatelessWidget {
  const ArticlesVerticalList({
    super.key,
    this.scrollController,
    required this.scrollPhysics,
    required this.articles,
    required this.articleType,
    required this.onArticleTap,
  });

  final ScrollController? scrollController;
  final ScrollPhysics scrollPhysics;
  final List<Article> articles;
  final String articleType;
  final Function(Article, String) onArticleTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      physics: scrollPhysics,
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        final isFirstItem = index == 0;
        final isLastItem = index == articles.length - 1;
        final heroTag = "${article.urlToImage}/$articleType/$index";
        final urlToImage = article.urlToImage;
        final title = article.title;
        final sourceName = article.source.name;
        return Container(
          padding: EdgeInsets.only(
            top: isFirstItem ? 0 : 20,
            bottom: isLastItem ? 20 : 0,
          ),
          child: ArticleCardHorizontal(
            onArticleTap: () {
              onArticleTap(article, heroTag);
            },
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
