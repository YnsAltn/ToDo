import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/screens/add_task/state/add_task_state.dart';

class AddTaskNotifier extends StateNotifier<AddTaskState> {
  AddTaskNotifier() : super(AddTaskState());

  void setDate(DateTime userSelectedDate) {
    state = state.copyWith(selectedDate: userSelectedDate);
  }

  void setHour(int userSelectedHour) =>
      state = state.copyWith(selectedHour: userSelectedHour);

  void setMinute(int userSelectedMinute) {
    state = state.copyWith(selectedMinute: userSelectedMinute);
  }

  void setTaskHeader(String userTaskHeader) {
    state = state.copyWith(taskHeader: userTaskHeader);
  }

  void setTaskDescription(String userDescription) {
    state = state.copyWith(taskDescription: userDescription);
  }
}

final addTaskProvider = StateNotifierProvider<AddTaskNotifier, AddTaskState>(
  (ref) => AddTaskNotifier(),
);
