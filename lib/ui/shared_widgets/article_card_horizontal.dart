import 'package:flutter/material.dart';
import 'article_image.dart';
import '../../theme/app_font_styles.dart';

class ArticleCardHorizontal extends StatelessWidget {
  const ArticleCardHorizontal({
    super.key,
    required this.onArticleTap,
    required this.urltoImage,
    required this.title,
    required this.sourceName,
    required this.heroImageTag,
  });
  final VoidCallback onArticleTap;
  final String urltoImage;
  final String title;
  final String sourceName;
  final String heroImageTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onArticleTap,
      overlayColor: const MaterialStatePropertyAll(
        Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFontStyles.headline5.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    sourceName,
                    style: AppFontStyles.body2Regular.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: heroImageTag,
                  child: ArticleImage(
                    width: 112,
                    height: 80,
                    urlToImage: urltoImage,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
