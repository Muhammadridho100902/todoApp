import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_get_storage/controller/task_controller.dart';
import 'package:todoapp_get_storage/utils/themes.dart';
import 'package:todoapp_get_storage/views/add_task.dart';
import 'package:todoapp_get_storage/widgets/button.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final _taskConroller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            label: "+Add Task",
            onTap: () async {
              await Get.to(()=> const AddTaskPage());
              _taskConroller.getTasks();
            },
          )
        ],
      ),
    );
  }
}
