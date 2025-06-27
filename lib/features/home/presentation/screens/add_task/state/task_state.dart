import 'package:flutter/material.dart';

class TaskState {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int selectedCategoryId;

  TaskState({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? selectedCategoryId,
  }) : selectedDate = selectedDate ?? DateTime.now(),
       selectedTime = selectedTime ?? TimeOfDay.now(),
       selectedCategoryId = selectedCategoryId ?? 0;

  TaskState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? selectedCategoryId,
  }) {
    return TaskState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}
