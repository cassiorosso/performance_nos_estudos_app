import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/controllers/navigation_controller.dart';
import 'package:performance_nos_estudos_app/view/components/app_bar_widget.dart';
import 'package:performance_nos_estudos_app/view/components/side_drawer_widget.dart';
import '../guia_estudos_page.dart';
import '../login_page.dart';
import 'calendar_page_tablet.dart';
import 'dashboard_page_tablet.dart';
import 'revisoes_page_tablet.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({super.key});

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final navigationController = GetIt.I<NavigationController>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      appBar: appBarWidget,
      drawer: SideDrawer(keyScaffold: _scaffoldKey, isFixed: false,),
      body:  ValueListenableBuilder<int>(
                valueListenable: navigationController,
                builder: (context, value, child) {
                  switch (value) {
                    case 0:
                      return const DashboardPageTablet();
                    case 1:
                      return RevisoesPageTablet();
                    case 2:
                      return const CalendarPageTablet();
                    case 3:
                      return const GuiaEstudosPage();
                    case 4:
                      return const LoginPage();  
                    default:
                      return (Container());
                  }
                })
    );
  }
}