import 'package:flutter/material.dart';
import 'controllers/navigation_controller.dart';
import 'responsive/responsive_layout.dart';
import 'view/desktop/home_page_desktop.dart';
import 'view/mobile/home_page_mobile.dart';
import 'view/tablet/home_page_tablet.dart';

void main() {
  runApp(const MyApp());
}

 final navigationController = NavigationController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ResponsiveLayout(
        mobileHome:  HomePageMobile(),
        tabletHome:  HomePageTablet(),
        desktopHome: HomePageDesktop(),
      ),
    );
  }
}

