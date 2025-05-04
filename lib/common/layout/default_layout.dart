import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.title,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: renderAppbar(),
      bottomNavigationBar: bottomNavigationBar,
      body: child,
    );
  }

  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
