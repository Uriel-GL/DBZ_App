import 'package:flutter/material.dart';

/// AppBar por defecto de la App. 
class AppBarDbz extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppBarDbz({super.key, this.title = ""});

  @override
  State<AppBarDbz> createState() => _AppBarDbz();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarDbz extends State<AppBarDbz> {
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/banner.png',
        height: 90,
      ),
      backgroundColor: Colors.black,
      leading: _leandingActive(widget.title),
      actions: [
        IconButton(
          onPressed: () {}, 
          icon: const Icon(
            Icons.notifications,
            size: 28,
            color: Colors.white70,
          )
        )
      ],
    );
  }
}
Widget _leandingActive(String title) {
  if (title != ""){
    return Builder(builder: (context) {
        return IconButton(
          onPressed: () {

          }, 
          icon: const Icon(
            Icons.menu,
            size: 28,
            color: Colors.white70,
          )
        );
      }
    );
  } else {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () => Navigator.pop(context), 
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white70,
          size: 28
        ),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    });
  }
}