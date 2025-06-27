import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  final String taskId;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final bool isCompleted;

  TaskModel({
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'hour': time.hour,
      'minute': time.minute,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: (json['date'] as Timestamp).toDate(),
      time: TimeOfDay(hour: json['hour'] as int, minute: json['minute'] as int),
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
