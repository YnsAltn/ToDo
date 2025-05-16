class AddTaskState {
  final DateTime selectedDate;
  final int selectedHour;
  final int selectedMinute;
  final String taskHeader;
  final String taskDescription;

  AddTaskState({
    DateTime? selectedDate,
    this.selectedHour = 0,
    this.selectedMinute = 0,
    this.taskDescription = "",
    this.taskHeader = "",
  }) : selectedDate = selectedDate ?? DateTime.now();

  AddTaskState copyWith({
    DateTime? selectedDate,
    int? selectedHour,
    int? selectedMinute,
    String? taskHeader,
    String? taskDescription,
  }) {
    return AddTaskState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedHour: selectedHour ?? this.selectedHour,
      selectedMinute: selectedMinute ?? this.selectedMinute,
      taskHeader: taskHeader ?? this.taskHeader,
      taskDescription: taskDescription ?? this.taskDescription,
    );
  }
}
