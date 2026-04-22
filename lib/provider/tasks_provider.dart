import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> allTasks = [];

  Future<void> addNewTask(TaskModel tm) async {
    allTasks.add(tm);
    await storeTasksToStorage();
    notifyListeners();
  }

  Future<void> switchStatus(int index) async {
    allTasks[index].isCompleted = !allTasks[index].isCompleted;
    await storeTasksToStorage();
    notifyListeners();
  }

  Future<void> deleteTask(TaskModel task) async {
    allTasks.remove(task);
    await storeTasksToStorage();
    notifyListeners();
  }

  Future<void> storeTasksToStorage() async {
    final preferences = await SharedPreferences.getInstance();

    final jsonData = allTasks.map((e) => e.toJson()).toList();
    final encodedData = jsonEncode(jsonData);

    await preferences.setString("tasks", encodedData);
  }

  Future<void> getTasksFromStorage() async {
    final preferences = await SharedPreferences.getInstance();

    final encodedData = preferences.getString("tasks");

    if (encodedData != null) {
      final decodedData = jsonDecode(encodedData) as List;

      allTasks = decodedData
          .map((e) => TaskModel.fromJson(e))
          .toList();
    }

    notifyListeners();
  }
}