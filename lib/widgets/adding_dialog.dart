import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task_model.dart' show TaskModel;
import 'package:todo_list/provider/tasks_provider.dart' show TasksProvider;

class AddingDialog extends StatefulWidget {
  const AddingDialog({super.key});

  @override
  State<AddingDialog> createState() => _AddingDialogState();
}

class _AddingDialogState extends State<AddingDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Task ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Task Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                hintText: "Task Subtitle",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        subtitleController.text.isEmpty) {
                      return;
                    }

                    //listen : false because we don't want to rebuild the dialog when the provider changes,
                    // we just want to call the addNewTask method.
                    Provider.of<TasksProvider>(
                      context,
                      listen: false,
                    ).addNewTask(
                      TaskModel(
                        title: titleController.text,
                        subtitle: subtitleController.text,
                        createdAt: DateTime.now(),
                      ),
                    );
                    // Handle adding the new task to the list
                    Navigator.pop(context);
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


