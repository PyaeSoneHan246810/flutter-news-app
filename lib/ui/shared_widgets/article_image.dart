import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_settings/bloc/current_theme_bloc.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({
    super.key,
    required this.width,
    required this.height,
    required this.urlToImage,
  });

  final double width;
  final double height;
  final String urlToImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentThemeBloc, CurrentThemeState>(
      builder: (context, currentThemeState) {
        return CachedNetworkImage(
          width: width,
          height: height,
          fit: BoxFit.cover,
          imageUrl: urlToImage,
          placeholder: (context, url) {
            return Image.asset(
              currentThemeState.isDarkThemeEnabled
                  ? "assets/images/article_image_placeholder_dark.jpg"
                  : "assets/images/article_image_placeholder.png",
              fit: BoxFit.cover,
            );
          },
          errorWidget: (context, url, error) {
            return Image.asset(
              currentThemeState.isDarkThemeEnabled
                  ? "assets/images/article_image_placeholder_dark.jpg"
                  : "assets/images/article_image_placeholder.png",
              fit: BoxFit.cover,
            );
          },
        );
      },
    );
  }
}
