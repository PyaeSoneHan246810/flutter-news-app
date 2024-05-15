import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../shared_widgets/action_icon_button.dart';
import '../widgets/web_view_navigation_controls.dart';
import '../../../theme/app_font_styles.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.articleUrl,
  });
  final String articleUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var _loadingPercentage = 0;
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              _loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _loadingPercentage = 100;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.articleUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Article',
          style: AppFontStyles.title.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: ActionIconButton(
          iconData: MaterialSymbols.arrow_back_outlined,
          size: 20,
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          NavigationControls(controller: _webViewController),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: _webViewController,
            ),
            if (_loadingPercentage < 100)
              LinearProgressIndicator(
                value: _loadingPercentage / 100.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
          ],
        ),
      ),
    );
  }
}
