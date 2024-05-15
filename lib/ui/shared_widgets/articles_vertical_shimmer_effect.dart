import 'package:flutter/material.dart';
import '../../theme/app_font_styles.dart';
import 'package:shimmer/shimmer.dart';

class ArticlesVerticalShimmerEffect extends StatelessWidget {
  const ArticlesVerticalShimmerEffect({
    super.key,
    required this.scrollPhysics,
  });
  final ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: scrollPhysics,
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;
        final isLastItem = index == 12 - 1;
        return Container(
          padding: EdgeInsets.only(
            top: isFirstItem ? 0 : 20,
            bottom: isLastItem ? 20 : 0,
          ),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.background,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Loading article...",
                      style: AppFontStyles.headline4,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/article_image_placeholder.png",
                      width: 112,
                      height: 80,
                      fit: BoxFit.cover,
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
