import 'package:flutter/material.dart';
import 'package:todoapp_get_storage/utils/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const Text(
        "Theme Data",
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: Icon(
          Icons.nightlight_round_rounded,
          size: 20,
        ),
      ),
      actions: [
        Icon(Icons.person,size: 20,),
        const SizedBox(width: 20,),
      ],
    );
  }
}
