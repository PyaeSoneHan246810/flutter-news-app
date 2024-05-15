import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared_widgets/toast_bar.dart';
import '../../bookmark/bloc/bookmarks_hydrated_bloc.dart';
import '../../shared_widgets/article_image.dart';
import '../../../domain/model/article.dart';
import '../../../theme/app_font_styles.dart';
import '../../shared_widgets/action_icon_button.dart';
import '../widgets/open_article_button.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({
    super.key,
    required this.article,
    required this.heroTag,
  });
  final Article article;
  final String heroTag;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      if (mounted) {
        toastBar("Unable to load the article.", MaterialSymbols.info)
            .show(context);
      }
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM d, yyyy').format(
      DateTime.parse(widget.article.publishedAt),
    );
    final bookmarksHydratedBloc =
        BlocProvider.of<BookmarksHydratedBloc>(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Hero(
                    tag: widget.heroTag,
                    child: ArticleImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      urlToImage: widget.article.urlToImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height * 0.30,
                right: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding:
                        const EdgeInsets.only(left: 28, top: 28, right: 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.article.title,
                          style: AppFontStyles.headline3.copyWith(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "${widget.article.source.name} • $formattedDate",
                          style: AppFontStyles.body2Regular.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                widget.article.author,
                                style: AppFontStyles.body2Regular.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Text(
                          widget.article.content,
                          style: AppFontStyles.body1Regular.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            height: 1.75,
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ScrollToHide(
                  scrollController: _scrollController,
                  hideDirection: Axis.vertical,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 4.0,
                        sigmaY: 4.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withOpacity(0.75),
                        ),
                        child: Row(
                          children: [
                            ActionIconButton(
                              iconData: MaterialSymbols.arrow_back_outlined,
                              size: 24,
                              onPressed: () {
                                // navigate back
                                context.pop();
                              },
                            ),
                            const Spacer(),
                            BlocBuilder<BookmarksHydratedBloc, BookmarksState>(
                              builder: (context, state) {
                                final bookmarks = state.bookmarks;
                                final isAlreadyBookmarked = bookmarks.any(
                                  (element) =>
                                      element.urlToImage ==
                                      widget.article.urlToImage,
                                );
                                return ActionIconButton(
                                  iconData: (!isAlreadyBookmarked)
                                      ? MaterialSymbols.bookmark_outlined
                                      : MaterialSymbols.bookmark_filled,
                                  size: 24,
                                  onPressed: () {
                                    if (!isAlreadyBookmarked) {
                                      bookmarksHydratedBloc
                                          .add(BookmarkAdded(widget.article));
                                    } else {
                                      bookmarksHydratedBloc
                                          .add(BookmarkRemoved(widget.article));
                                    }
                                  },
                                );
                              },
                            ),
                            ActionIconButton(
                              iconData: MaterialSymbols.share_outlined,
                              size: 24,
                              onPressed: () {
                                // share article
                                Share.share(
                                  "Hey! Check out this article from ${widget.article.source.name} here: ${widget.article.url}",
                                );
                              },
                            ),
                            ActionIconButton(
                              iconData: MaterialSymbols.public_outlined,
                              size: 24,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  enableDrag: true,
                                  showDragHandle: false,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return GiffyBottomSheet.image(
                                      Image.asset(
                                        "assets/animations/smartphone_animation.gif",
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        "Read article",
                                        style: AppFontStyles.headline3.copyWith(
                                          fontSize: 24,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Select the option to read the article.",
                                          style: AppFontStyles.body1Regular
                                              .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            OpenArticleButton(
                                              title: "Open in browser",
                                              onPressed: () {
                                                // view article in web browser
                                                _launchUrl(widget.article.url);
                                                // close dialog
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            OpenArticleButton(
                                              title: "Open in app",
                                              onPressed: () {
                                                // view article in webview in app
                                                context.pushNamed(
                                                  "/webView",
                                                  pathParameters: {
                                                    "url": widget.article.url,
                                                  },
                                                );
                                                // close dialog
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
