import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 244, 22, 22),
                  Color.fromARGB(210, 186, 39, 39)
                ],
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Movie Genre',
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 4, 4),
                    fontSize: 23,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Action',
              style: TextStyle(
                color: Color.fromARGB(255, 244, 22, 22),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Adventure',
              style: TextStyle(
                color: Color.fromARGB(255, 244, 22, 22),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Biography',
              style: TextStyle(
                color: Color.fromARGB(255, 244, 22, 22),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Crime',
              style: TextStyle(
                color: Color.fromARGB(255, 244, 22, 22),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Comedy',
              style: TextStyle(
                color: Color.fromARGB(255, 244, 22, 22),
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
