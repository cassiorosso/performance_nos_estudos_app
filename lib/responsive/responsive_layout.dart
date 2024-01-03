import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileHome;
  final Widget desktopHome;

  const ResponsiveLayout({super.key, 
    required this.mobileHome,
    required this.desktopHome,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1100) {
          return mobileHome;
        } else {
          return desktopHome;
        }
      },
    );
  }
}