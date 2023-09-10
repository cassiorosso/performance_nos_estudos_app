import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileHome;
  final Widget tabletHome;
  final Widget desktopHome;

  const ResponsiveLayout({super.key, 
    required this.mobileHome,
    required this.tabletHome,
    required this.desktopHome,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return mobileHome;
        } else if (constraints.maxWidth < 1100) {
          return tabletHome;
        } else {
          return desktopHome;
        }
      },
    );
  }
}