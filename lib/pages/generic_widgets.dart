import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(color: Colors.red),
          TextButton(
            onPressed: () {},
            child: const Text("teste"),
          ),
        ],
      ),
    );
  }
}

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GlobalAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
