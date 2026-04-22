import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/provider/dark_mode.dart';
import 'package:todo_list/provider/tasks_provider.dart';
import 'package:todo_list/widgets/adding_dialog.dart';
import 'package:todo_list/widgets/task_card.dart';

class TabsScreens extends StatefulWidget {
  const TabsScreens({super.key});

  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  @override
  void initState() {
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).getTasksFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TasksProvider, DarkModeProvider>(
      builder: (context, taskProvider, mode, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Sticky App"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(mode.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: mode.switchMode,
                color: mode.isDark ? Colors.white : Colors.black,
              ),
            ],
          ),
          body: DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: "All"),
                      Tab(text: "Pending"),
                      Tab(text: "Completed"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTaskList(
                          tasks: taskProvider.allTasks,
                          provider: taskProvider,
                        ),
                        _buildTaskList(
                          tasks: taskProvider.allTasks
                              .where((t) => !t.isCompleted)
                              .toList(),
                          provider: taskProvider,
                        ),
                        _buildTaskList(
                          tasks: taskProvider.allTasks
                              .where((t) => t.isCompleted)
                              .toList(),
                          provider: taskProvider,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const AddingDialog(),
              );
            },
          ),
        );
      },
    );
  }

  /// 🔥 Reusable List Builder
  Widget _buildTaskList({
    required List<TaskModel> tasks,
    required TasksProvider provider,
  }) {
    if (tasks.isEmpty) {
      return const Center(child: Text("No tasks yet"));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return TaskCard(
          taskModel: task,
          onSwitch: () {
            provider.switchStatus(provider.allTasks.indexOf(task));
          },
          onHold: () {
            showDialog(
              context: context,
              builder: (_) => DeleteDialog(tm: task),
            );
          },
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}

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
