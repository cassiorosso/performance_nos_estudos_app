import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:performance_nos_estudos_app/controllers/revisoes_controller.dart';
import 'package:performance_nos_estudos_app/services/database_service.dart';
import 'controllers/navigation_controller.dart';
import 'responsive/responsive_layout.dart';
import 'stores/area_store.dart';
import 'view/desktop/home_page_desktop.dart';
import 'view/mobile/home_page_mobile.dart';
import 'view/tablet/home_page_tablet.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<NavigationController>(NavigationController());
  GetIt.I.registerSingleton<HasuraService>(HasuraService(
      HasuraConnect("https://sacred-sole-29.hasura.app/v1/graphql", headers: {
    "content-type": "application/json",
    "x-hasura-admin-secret":
        "IZ30mP94zVJRi8pHioOtZoZcg8zxXjYpqBZQI6EFhqFhhS3G1NMuFGxwnVS0aoqx"
  })));
  GetIt.I.registerSingleton<IDatabase>(GetIt.I<HasuraService>());
  GetIt.I.registerSingleton<AreaStore>(AreaStore());
  GetIt.I.registerSingleton<RevisoesController>(RevisoesController());

  runApp(const MyApp());
}

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
        mobileHome: HomePageMobile(),
        tabletHome: HomePageTablet(),
        desktopHome: HomePageDesktop(),
      ),
    );
  }
}
