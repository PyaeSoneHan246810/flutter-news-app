import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:go_router/go_router.dart';
import '../bloc/bookmarks_hydrated_bloc.dart';
import '../../nav_host/bloc/navigation_visibility_bloc.dart';
import '../../shared_widgets/large_title_top_bar.dart';
import '../../shared_widgets/article_card_horizontal.dart';
import '../widgets/empty_bookmarks_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({
    super.key,
  });

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // initialize scroll controller
    _scrollController = ScrollController();

    // add listener to scroll controller
    _scrollController.addListener(() {
      final scrollDirection = _scrollController.position.userScrollDirection;
      if (scrollDirection == ScrollDirection.forward) {
        context
            .read<NavigationVisibilityBloc>()
            .add(NavigationVisibilityChanged(isVisible: true));
      } else {
        context
            .read<NavigationVisibilityBloc>()
            .add(NavigationVisibilityChanged(isVisible: false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarksHydratedBloc =
        BlocProvider.of<BookmarksHydratedBloc>(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const LargeTitleTopBar(
              title: "Bookmarks",
              actions: [],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: BlocBuilder<BookmarksHydratedBloc, BookmarksState>(
                  builder: (context, state) {
                    if (state is BookmarksLoaded) {
                      final bookmarks = state.bookmarks;
                      return bookmarks.isEmpty
                          ? const EmptyBookmarkWidget()
                          : ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: bookmarks.length,
                              itemBuilder: (context, index) {
                                final bookmark = bookmarks[index];
                                final heroTag =
                                    "${bookmark.urlToImage}/BookmarkedArticle";
                                return Container(
                                  padding: EdgeInsets.only(
                                    top: (index == 0) ? 0 : 20,
                                    bottom: (index == bookmarks.length - 1)
                                        ? 20
                                        : 0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        bookmarksHydratedBloc
                                            .add(BookmarkRemoved(bookmark));
                                      },
                                      background: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                MaterialSymbols
                                                    .bookmark_remove_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: ArticleCardHorizontal(
                                        onArticleTap: () {
                                          context.pushNamed(
                                            "/article",
                                            extra: bookmark,
                                            pathParameters: {
                                              "heroTag": heroTag,
                                            },
                                          );
                                        },
                                        urltoImage: bookmark.urlToImage,
                                        title: bookmark.title,
                                        sourceName: bookmark.source.name,
                                        heroImageTag: heroTag,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                    return const EmptyBookmarkWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
