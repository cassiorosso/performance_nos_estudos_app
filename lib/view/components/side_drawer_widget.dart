import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/controllers/navigation_controller.dart';
import 'package:performance_nos_estudos_app/view/login_page.dart';

import '../../controllers/auth_controller.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key, this.keyScaffold, required this.isFixed});

  final GlobalKey<ScaffoldState>? keyScaffold;
  final bool isFixed;
  final navigationController = GetIt.I<NavigationController>();
  final _authController = AuthController();

  closeDrawer() async {
    if (isFixed == false) keyScaffold!.currentState!.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var drawerTextColor = const TextStyle(
      color: Colors.white,
    );
    var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
    return Drawer(
      backgroundColor: Colors.blue[700],
      elevation: 0,
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(
              child: Image.asset('assets/images/cerebro.png'),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.home, color: Colors.white,),
              title: Text(
                'P Á G I N A  I N I C I A L',
                style: drawerTextColor,
              ),
              onTap: () {
                closeDrawer();
                navigationController.changePage(0);
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.pie_chart_rounded, color: Colors.white),
              title: Text(
                'D A S H B O A R D',
                style: drawerTextColor,
              ),
              onTap: () {
                closeDrawer();
                navigationController.changePage(1);
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.list_alt, color: Colors.white,),
              title: Text(
                'R E V I S Õ E S',
                style: drawerTextColor,
              ),
              onTap: () {
                navigationController.changePage(2);
                closeDrawer();
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.calendar_month, color: Colors.white),
              title: Text(
                'C A L E N D Á R I O',
                style: drawerTextColor,
              ),
              onTap: () {
                navigationController.changePage(3);
                closeDrawer();
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.book, color: Colors.white),
              title: Text(
                'G U I A  D E  E S T U D O S ',
                style: drawerTextColor,
              ),
              onTap: () {
                closeDrawer();
                navigationController.changePage(4);
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                'S A I R',
                style: drawerTextColor,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.logout),
                            ),
                            Flexible(
                              child: Text(
                                "Tem certeza que deseja sair da plataforma?",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[800]),
                                child: const Text("Não",
                                    style: TextStyle(color: Colors.white))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  // Lógica
                                  _authController.auth0Web.logout();
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginPage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[800]),
                                child: const Text(
                                  "Sim",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      );
                    });
                closeDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }
}
