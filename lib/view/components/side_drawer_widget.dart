import 'package:flutter/material.dart';

import '../../main.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key, this.keyScaffold, required this.isFixed});

  final GlobalKey<ScaffoldState>? keyScaffold;
  final bool isFixed;

  closeDrawer() async {
    if (isFixed == false) keyScaffold!.currentState!.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var drawerTextColor = TextStyle(
      color: Colors.grey[600],
    );
    var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
    return Drawer(
      backgroundColor: Colors.grey[300],
      elevation: 0,
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(
              child: Image.asset('assets/images/logo2.png'),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'D A S H B O A R D',
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
              leading: const Icon(Icons.list_alt),
              title: Text(
                'R E V I S Õ E S',
                style: drawerTextColor,
              ),
              onTap: () {
                navigationController.changePage(1);
                closeDrawer();
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(
                'C A L E N D Á R I O',
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
              leading: const Icon(Icons.book),
              title: Text(
                'G U I A  D E  E S T U D O S ',
                style: drawerTextColor,
              ),
              onTap: () {
                closeDrawer();
                navigationController.changePage(3);
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'S A I R',
                style: drawerTextColor,
              ),
              onTap: () {
                navigationController.changePage(4);
                closeDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }
}
