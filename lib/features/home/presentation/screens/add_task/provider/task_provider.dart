import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/screens/add_task/service/task_service.dart';
import 'package:todo/features/home/presentation/screens/add_task/state/task_state.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(TaskState());

  final _taskService = TaskService();

  final List<String> categoryList = [
    "Kişisel",
    "Okul",
    "İş",
    "Alışveriş",
    "Ev",
    "Diğer",
  ];

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    try {
      await _taskService.addTask(
        title: title,
        description: description,
        date: state.selectedDate,
        time:
            '${state.selectedTime.hour.toString().padLeft(2, '0')}:${state.selectedTime.minute.toString().padLeft(2, '0')}',
        category: categoryList[state.selectedCategoryId],
      );
    } catch (e) {
      rethrow;
    }
  }

  void updateSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateSelectedTime(TimeOfDay time) {
    state = state.copyWith(selectedTime: time);
  }

  void updateSelectedCategoryId(int id) {
    state = state.copyWith(selectedCategoryId: id);
  }
}
