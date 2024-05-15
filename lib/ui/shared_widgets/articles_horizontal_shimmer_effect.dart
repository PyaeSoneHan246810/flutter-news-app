import 'package:flutter/material.dart';
import '../../theme/app_font_styles.dart';
import 'package:shimmer/shimmer.dart';

class ArticlesHorizontalShimmerEffect extends StatelessWidget {
  const ArticlesHorizontalShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;
        final isLastItem = index == 4 - 1;
        return Padding(
          padding: EdgeInsets.only(
            left: isFirstItem ? 28 : 20,
            right: isLastItem ? 28 : 0,
          ),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.background,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/article_image_placeholder.png",
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.width * 0.65,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Loading article...",
                          style: AppFontStyles.headline4,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
