import 'dart:ui';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_get_storage/utils/notify_helper.dart';
import 'package:todoapp_get_storage/utils/themes.dart';
import 'package:todoapp_get_storage/widgets/addtaskbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDateTime = DateTime.now();
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
        backgroundColor: context.theme.backgroundColor,
        body: Column(
          children: [
            const AddTaskBar(),
            _addDateBar(),
            // _showTask(),
          ],
        ));
  }

  // _showTask(){
  //   return Expanded(child: );
  // }

  _addDateBar(){
    return Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryClr,
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                dayTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                onDateChange: (date){
                  _selectedDateTime = date;
                },
              ),
            );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
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
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_rounded,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      actions: [
        CircleAvatar(
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.black87,
            child: Icon(
              Icons.person,
              size: 20,
              color: Get.isDarkMode ? Colors.black : Colors.white,
            )),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
