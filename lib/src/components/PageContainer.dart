import 'package:flutter/material.dart';
import 'package:study_alert/src/style_global.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool withPadding;
  final bool scrollable;
  final Color backgroudColor;

  const PageContainer({
    super.key,
    required this.child,
    this.title,
    this.withPadding = true,
    this.scrollable = false,
    this.backgroudColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final content =
        withPadding
            ? Padding(padding: const EdgeInsets.all(16.0), child: child)
            : child;

    final body = scrollable ? SingleChildScrollView(child: content) : content;

    return Scaffold(
      backgroundColor: backgroudColor,
      appBar:
          title != null
              ? AppBar(
                title: Text(title!),
                backgroundColor: BusuuColors.blue400,
              )
              : null,
      body: body,
    );
  }
}
