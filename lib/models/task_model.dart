import 'dart:convert';

class TaskModel {
  String title;
  String subtitle;
  DateTime createdAt;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.createdAt,
    this.isCompleted = false,
  });

  factory TaskModel.fromRawJson(String str) =>
      TaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    title: json["title"],
    subtitle: json["subtitle"],
    createdAt: DateTime.parse(json["created_at"]),
    isCompleted: json["is_completed"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "created_at": createdAt.toIso8601String(),
    "is_completed": isCompleted,
  };
}
