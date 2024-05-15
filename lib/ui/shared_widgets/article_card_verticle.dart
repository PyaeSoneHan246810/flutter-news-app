import 'package:flutter/material.dart';
import 'article_image.dart';
import '../../theme/app_font_styles.dart';

class ArticleCardVertical extends StatelessWidget {
  const ArticleCardVertical({
    super.key,
    required this.onArticleTap,
    required this.cardWidth,
    required this.cardHeight,
    required this.imageWidth,
    required this.imageHeight,
    required this.urltoImage,
    required this.title,
    required this.sourceName,
    required this.heroImageTag,
  });
  final VoidCallback onArticleTap;
  final double cardWidth;
  final double cardHeight;
  final double imageWidth;
  final double imageHeight;
  final String urltoImage;
  final String title;
  final String sourceName;
  final String heroImageTag;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onArticleTap,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: heroImageTag,
                  child: ArticleImage(
                    width: imageWidth,
                    height: imageHeight,
                    urlToImage: urltoImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 4,
                ),
                child: Text(
                  title,
                  style: AppFontStyles.headline4.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: Text(
                  sourceName,
                  style: AppFontStyles.body2Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
