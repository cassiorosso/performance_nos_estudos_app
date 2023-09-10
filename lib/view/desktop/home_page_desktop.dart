import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/view/components/app_bar_widget.dart';
import 'package:performance_nos_estudos_app/view/components/side_drawer_widget.dart';
import 'package:performance_nos_estudos_app/view/desktop/calendar_page_desktop.dart';
import 'package:performance_nos_estudos_app/view/desktop/dashboard_page_desktop.dart';
import 'package:performance_nos_estudos_app/view/desktop/revisoes_page_desktop.dart';
import 'package:performance_nos_estudos_app/view/guia_estudos_page.dart';
import 'package:performance_nos_estudos_app/view/login_page.dart';

import '../../main.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: appBarWidget,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideDrawer(isFixed: true,),
            ValueListenableBuilder<int>(
                valueListenable: navigationController,
                builder: (context, value, child) {
                  switch (value) {
                    case 0:
                      return const DashboardPageDesktop();
                    case 1:
                      return const RevisoesPage();
                    case 2:
                      return const CalendarPageDesktop();
                    case 3:
                      return const GuiaEstudosPage();
                    case 4:
                      return const LoginPage();  
                    default:
                      return (Container());
                  }
                })
          ],
        ),
      ),
    );
  }
}
