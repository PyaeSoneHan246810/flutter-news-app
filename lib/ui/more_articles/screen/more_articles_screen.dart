import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import '../../shared_widgets/large_title_top_bar.dart';
import '../../shared_widgets/articles_vertical_shimmer_effect.dart';
import '../../shared_widgets/error_retry_message.dart';
import '../../home/bloc/articles_bloc.dart';
import '../../shared_widgets/articles_vertical_list.dart';
import '../../shared_widgets/action_icon_button.dart';

class MoreArticlesScreen extends StatefulWidget {
  const MoreArticlesScreen({super.key});

  @override
  State<MoreArticlesScreen> createState() => _MoreArticlesScreenState();
}

class _MoreArticlesScreenState extends State<MoreArticlesScreen> {
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

  @override
  Widget build(BuildContext context) {
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
                bottom: 0,
                child: Column(
                  children: [
                    const LargeTitleTopBar(title: "Articles", actions: []),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: BlocBuilder<ArticlesBloc, ArticlesState>(
                          builder: (context, state) {
                            if (state is ArticlesFailure) {
                              return ErrorRetryMessage(
                                onRetry: () {
                                  context
                                      .read<ArticlesBloc>()
                                      .add(ArticlesFetched());
                                },
                              );
                            }
                            if (state is! ArticlesSuccess) {
                              return const ArticlesVerticalShimmerEffect(
                                  scrollPhysics:
                                      AlwaysScrollableScrollPhysics());
                            }
                            return ArticlesVerticalList(
                              scrollController: _scrollController,
                              scrollPhysics:
                                  const AlwaysScrollableScrollPhysics(),
                              articles: state.articles,
                              articleType: "MoreArticles",
                              onArticleTap: (article, heroTag) {
                                context.pushNamed(
                                  "/article",
                                  extra: article,
                                  pathParameters: {
                                    "heroTag": heroTag,
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
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
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
