import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp_get_storage/utils/notify_helper.dart';
import 'package:todoapp_get_storage/utils/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

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
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Mode"
                  : "Activated Dark Mode");
          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Icons.nightlight_round_rounded,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/prof.png",
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
