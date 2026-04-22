import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/provider/dark_mode.dart';
import 'package:todo_list/provider/tasks_provider.dart';
import 'package:todo_list/widgets/adding_dialog.dart';
import 'package:todo_list/widgets/task_card.dart';
// import 'package:intl/intl.dart'; // تأكد من تشغيل flutter pub add intl

class TabsScreens extends StatefulWidget {
  const TabsScreens({super.key});

  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  @override
  void initState() {
    super.initState();

    // Load tasks from storage when the screen initializes
    Provider.of<TasksProvider>(context, listen: false).getTasksFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TasksProvider, DarkModeProvider>(
      builder: (context, taskConsumer, mode, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sticky App"),
            centerTitle: true,

            actions: [
              IconButton(
                icon: Icon(mode.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  mode.switchMode();
                },
                color: mode.isDark ? Colors.white : Colors.black,
              ),
            ],
          ),

          body: DefaultTabController(
            length: 3, // عدد التابات
            child: SafeArea(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "All"),
                      Tab(text: "Pending"),
                      Tab(text: "Completed"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: taskConsumer.allTasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              taskModel: taskConsumer.allTasks[index],
                              onSwitch: () {
                                // setState(() {
                                //   taskConsumer.allTasks[index].isCompleted =
                                //       !taskConsumer.allTasks[index].isCompleted;
                                // });

                                taskConsumer.switchStatus(index);
                              },
                              onHold: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteDialog(
                                    tm: taskConsumer.allTasks[index],
                                  ),
                                );
                                // Handle long press if needed
                              },
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: taskConsumer.allTasks.length,
                          itemBuilder: (context, index) {
                            return taskConsumer.allTasks[index].isCompleted
                                ? SizedBox()
                                : TaskCard(
                                    taskModel: taskConsumer.allTasks[index],
                                    onSwitch: () {
                                      // setState(() {
                                      //   taskConsumer.allTasks[index].isCompleted =
                                      //       !taskConsumer.allTasks[index].isCompleted;
                                      // });
                                      taskConsumer.switchStatus(index);
                                    },
                                    onHold: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DeleteDialog(
                                          tm: taskConsumer.allTasks[index],
                                        ),
                                      );
                                      // Handle long press if needed
                                    },
                                  );
                          },
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ), // 👈 top + bottom space
                          itemCount: taskConsumer.allTasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              taskModel: taskConsumer.allTasks[index],
                              onSwitch: () {
                                taskConsumer.switchStatus(index);
                              },
                              onHold: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteDialog(
                                    tm: taskConsumer.allTasks[index],
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddingDialog(),
              );
              // showGeneralDialog(
              //   context: context,
              //   barrierDismissible: true,
              //   barrierLabel: "Add Task",
              //   transitionDuration: Duration(milliseconds: 300),
              //   pageBuilder: (context, animation, secondaryAnimation) {
              //     return AddingDialog();
              //   },
              //   transitionBuilder:
              //       (context, animation, secondaryAnimation, child) {
              //         return ScaleTransition(
              //           scale: CurvedAnimation(
              //             parent: animation,
              //             curve: Curves.easeOutBack, //  zoom effect
              //           ),
              //           child: FadeTransition(opacity: animation, child: child),
              //         );
              //       },
              // );
              // Handle adding a new task
            },
          ),
        );
      },
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.tm});
  final TaskModel tm;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Task"),
      content: Text("Are you sure you want to delete this task?"),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          onPressed: () {
            //listen : false because we don't want to rebuild the dialog when the provider changes,
            // we just want to call the addNewTask method.
            Provider.of<TasksProvider>(context, listen: false).deleteTask(tm);
            Navigator.pop(context);

            // Handle adding the new task to the list
          },
          child: Text("Delete"),
        ),

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
