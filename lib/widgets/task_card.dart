// Stateless Widget
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helper/consts.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/provider/dark_mode.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onSwitch,
    required this.onHold,
  });

  final TaskModel taskModel;
  final Function onSwitch;
  final Function onHold;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, mode, child) {
        return GestureDetector(
          onLongPress: () {
            onHold();
          },

          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: mode.isDark
                  ? Colors.white.withValues(
                      alpha: taskModel.isCompleted ? 0.25 : 0.60,
                    )
                  : primaryColor.withValues(
                      alpha: taskModel.isCompleted ? 0.05 : 0.5,
                    ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        taskModel.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: mode.isDark ? Colors.white : Colors.black,
                          decoration: taskModel.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      Checkbox(
                        checkColor: mode.isDark ? Colors.black : Colors.white,
                        fillColor: WidgetStatePropertyAll(
                          mode.isDark ? Colors.white : primaryColor,
                        ),
                        value: taskModel.isCompleted,
                        onChanged: (v) {
                          onSwitch();
                        },
                      ),
                    ],
                  ),
                  Text(
                    taskModel.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: mode.isDark
                          ? Colors.white
                          : taskModel.isCompleted
                          ? Colors.grey
                          : Colors.white,

                      fontWeight: FontWeight.bold,
                      decoration: taskModel.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        taskModel.createdAt
                            .toIso8601String()
                            .substring(0, 10)
                            .replaceAll("-", "/"),
                        style: TextStyle(
                          fontSize: 14,
                          color: taskModel.isCompleted
                              ? Colors.grey
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: taskModel.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      Text(
                        taskModel.createdAt.toIso8601String().substring(11, 16),
                        style: TextStyle(
                          fontSize: 14,
                          color: taskModel.isCompleted
                              ? Colors.grey
                              : Colors.white,

                          fontWeight: FontWeight.bold,
                          decoration: taskModel.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
