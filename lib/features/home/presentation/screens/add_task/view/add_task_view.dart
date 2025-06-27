import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/screens/add_task/provider/task_provider.dart';
import 'package:todo/features/home/presentation/screens/add_task/state/task_state.dart';
import 'package:intl/intl.dart';

final _taskHeader = TextEditingController();
final _taskDescription = TextEditingController();

class AddNewTaskView extends ConsumerStatefulWidget {
  const AddNewTaskView({super.key});

  @override
  ConsumerState<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends ConsumerState<AddNewTaskView> {
  @override
  Widget build(BuildContext context) {
    final taskNotifier = ref.read(taskProvider.notifier);
    final taskState = ref.watch(taskProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15.h),
              margin: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Görev Detayları",
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TaskHeaderWidget(taskNotifier: taskNotifier),
                  SizedBox(height: 15.h),
                  TaskDescriptionWidget(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.h),
              margin: EdgeInsets.symmetric(horizontal: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kategori",
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CategorySelectionWidget(
                    selectedCategoryId: taskState.selectedCategoryId,
                    onCategorySelected:
                        (id) => taskNotifier.updateSelectedCategoryId(id),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.h),
              margin: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tarih ve Saat",
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDatePickerButton(
                          context,
                          taskState,
                          taskNotifier,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildTimePickerButton(
                          context,
                          taskState,
                          taskNotifier,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.h),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await taskNotifier.addTask(
                      title: _taskHeader.text,
                      description: _taskDescription.text,
                    );
                    // Inputları temizle
                    _taskHeader.clear();
                    _taskDescription.clear();
                    // Başarılı mesajı göster
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Görev başarıyla kaydedildi'),
                          backgroundColor: Colors.teal,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Görev kaydedilirken bir hata oluştu: $e',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45.h),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Görevi Kaydet',
                  style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerButton(
    BuildContext context,
    TaskState taskState,
    TaskNotifier taskNotifier,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: taskState.selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(primary: Colors.teal),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              taskNotifier.updateSelectedDate(date);
            }
          },
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18.h, color: Colors.teal),
                SizedBox(width: 8.w),
                Text(
                  DateFormat('dd/MM/yyyy').format(taskState.selectedDate),
                  style: TextStyle(fontSize: 13.h, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerButton(
    BuildContext context,
    TaskState taskState,
    TaskNotifier taskNotifier,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: taskState.selectedTime,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(primary: Colors.teal),
                  ),
                  child: child!,
                );
              },
            );
            if (time != null) {
              taskNotifier.updateSelectedTime(time);
            }
          },
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 18.h, color: Colors.teal),
                SizedBox(width: 8.w),
                Text(
                  '${taskState.selectedTime.hour.toString().padLeft(2, '0')}:${taskState.selectedTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 13.h, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskDescriptionWidget extends StatelessWidget {
  const TaskDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Açıklama",
          style: TextStyle(
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _taskDescription,
          minLines: 2,
          maxLines: null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            hintText: "Görev Açıklamasını Gir",
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.teal),
            ),
          ),
        ),
      ],
    );
  }
}

class TaskHeaderWidget extends StatelessWidget {
  const TaskHeaderWidget({super.key, required this.taskNotifier});

  final TaskNotifier taskNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Başlık",
          style: TextStyle(
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _taskHeader,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            hintText: "Görev Başlığı",
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.teal),
            ),
          ),
        ),
      ],
    );
  }
}

class CategorySelectionWidget extends ConsumerWidget {
  final int selectedCategoryId;
  final Function(int) onCategorySelected;

  const CategorySelectionWidget({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.read(taskProvider.notifier).categoryList;

    return SizedBox(
      height: 35.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final isSelected = selectedCategoryId == index;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onCategorySelected(index),
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.teal : Colors.grey[100],
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color:
                          isSelected
                              ? Colors.teal
                              : Colors.teal.withOpacity(0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      categoryList[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.teal,
                        fontSize: 13.h,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
