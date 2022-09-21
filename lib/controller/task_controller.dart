import 'package:get/get.dart';
import 'package:todoapp_get_storage/Db/db_helper.dart';
import 'package:todoapp_get_storage/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  var taskList = <Task>[].obs;

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(
      tasks.map((data) => Task.fromjson(data)).toList(),
    );
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id)async{
    await DBHelper.update(id);
    getTasks();
  }

}
