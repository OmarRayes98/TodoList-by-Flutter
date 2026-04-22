
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/provider/tasks_provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.tm});

  final TaskModel tm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Task"),
      content: const Text("Are you sure you want to delete this task?"),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          onPressed: () {
            Provider.of<TasksProvider>(context, listen: false).deleteTask(tm);
            Navigator.pop(context);
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
