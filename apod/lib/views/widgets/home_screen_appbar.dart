import 'package:flutter/material.dart';

class HomeScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'APOD app',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
