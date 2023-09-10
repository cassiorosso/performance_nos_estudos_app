import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/view/components/app_bar_widget.dart';
import 'package:performance_nos_estudos_app/view/components/side_drawer_widget.dart';
import 'package:performance_nos_estudos_app/view/mobile/revisoes_page_mobile.dart';

import '../../main.dart';
import '../guia_estudos_page.dart';
import '../login_page.dart';
import 'calendar_page_mobile.dart';
import 'dashboard_page_mobile.dart';


class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                      return const DashboardPageMobile();
                    case 1:
                      return const RevisoesPageMobile();
                    case 2:
                      return const CalendarPageMobile();
                    case 3:
                      return const GuiaEstudosPage();
                    case 4:
                      return const LoginPage();  
                    default:
                      return (Container());
                  }
                }),
    );
  }
}