import 'package:flutter/material.dart';
// import 'package:hasura_connect/hasura_connect.dart';
// import 'package:performance_nos_estudos_app/view/login_page.dart';
// import 'controllers/dashboard_controller.dart';
import 'controllers/navigation_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'controllers/revisoes_controller.dart';
// import 'models/usuario_model.dart';
//import 'responsive/responsive_layout.dart';
// import 'services/database_service.dart';
// import 'stores/area_store.dart';
// import 'stores/user_store.dart';
//import 'view/desktop/home_page_desktop.dart';
import 'view/login_page.dart';
//import 'view/mobile/home_page_mobile.dart';

Future<void> main() async {
  //setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<NavigationController>(NavigationController());

  //PROVISÓRIO ------------------------------------------------------------------------
  // GetIt.I.registerSingleton<UsuarioStore>(UsuarioStore(
  //     user: UsuarioModel(
  //         email: "cassiorosso@hotmail.com",
  //         id: "auth0|655a3de37c99011f94019e3a",
  //         nome: "casio")));
  // GetIt.I.registerSingleton<HasuraService>(HasuraService(
  //     HasuraConnect("https://sacred-sole-29.hasura.app/v1/graphql", headers: {
  //   "content-type": "application/json",
  //   "x-hasura-admin-secret":
  //       "IZ30mP94zVJRi8pHioOtZoZcg8zxXjYpqBZQI6EFhqFhhS3G1NMuFGxwnVS0aoqx"
  // })));
  // GetIt.I.registerSingleton<IDatabase>(GetIt.I<HasuraService>());
  // GetIt.I.registerSingleton<AreaStore>(AreaStore());
  // GetIt.I.registerSingleton<RevisoesController>(RevisoesController());
  // GetIt.I.registerSingleton<DashboardController>(DashboardController());
  //PROVISÓRIO ------------------------------------------------------------------------

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt')],
      title: 'Perfomance nos Estudos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      // home: const ResponsiveLayout(
      //   mobileHome: HomePageMobile(),
      //   desktopHome: HomePageDesktop(),
      // ),
    );
  }
}
