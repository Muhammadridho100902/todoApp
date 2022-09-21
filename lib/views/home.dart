import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_get_storage/controller/task_controller.dart';
import 'package:todoapp_get_storage/models/task.dart';
import 'package:todoapp_get_storage/utils/notify_helper.dart';
import 'package:todoapp_get_storage/utils/themes.dart';
import 'package:todoapp_get_storage/widgets/addtaskbar.dart';
import 'package:todoapp_get_storage/widgets/task_tile.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = Get.put(TaskController());
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
            const SizedBox(
              height: 10,
            ),
            _showTask(),
          ],
        ));
  }

  _showTask() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task
                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (task.repeat == 'Weekly') {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (task.repeat == 'Monthly') {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDateTime)) {
                return AnimationConfiguration.staggeredList(
                position: index,
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(task),
                      )
                    ],
                  ),
                ),
              );
              } else{
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1 ? Get.height * 0.24 : Get.height * 0.32,
      color: Get.isDarkMode ? darkGryClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.grey[600] : Colors.green[300],
                borderRadius: BorderRadius.circular(10)),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              _taskController.delete(task);
              Get.back();
            },
            clr: Colors.red[300]!,
            context: context,
          ),
          const SizedBox(
            height: 10,
          ),
          _bottomSheetButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            clr: Colors.white,
            isClose: true,
            context: context,
          )
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: Get.width * 0.9,
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr,
            ),
            color: isClose == true ? Colors.transparent : clr,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  _addDateBar() {
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
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDateTime = date;
          });
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
          // notifyHelper.scheduledNotification();
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
