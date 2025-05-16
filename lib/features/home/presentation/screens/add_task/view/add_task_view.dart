import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/screens/add_task/provider/add_task_provider.dart'; // ConsumerWidget için gerekli

final _taskHeader = TextEditingController();
final _taskDescription = TextEditingController();

class AddNewTaskView extends ConsumerStatefulWidget {
  const AddNewTaskView({super.key});

  @override
  ConsumerState<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends ConsumerState<AddNewTaskView> {
  late DateTime _selectedDate;
  int selectedHour = DateTime.now().hour;
  int selectedMinute = DateTime.now().minute;
  int selectedCategoryId = 5;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final addTaskNotifier = ref.read(addTaskProvider.notifier);
    final addTaskState = ref.watch(addTaskProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Görev")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Başlık",
                style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              TaskHeaderWidget(addTaskNotifier: addTaskNotifier),
              SizedBox(height: 15.h),
              Text(
                "Açıklama",
                style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              TaskDescriptionWidget(),
              SizedBox(height: 15.h),
              Text(
                "Kategori Seç",
                style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.h),
              CategorySelectionWidget(
                ref: ref,
                selectedCategoryId: selectedCategoryId,
                categoryList: [
                  "Kişisel",
                  "Okul",
                  "İş",
                  "Alışveriş",
                  "Ev",
                  "Diğer",
                ],
                onCategorySelected:
                    (id) => setState(() => selectedCategoryId = id),
              ),
              Text(
                "Tarih ve Saat Seç",
                style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
              ),
              DateTimePickerWidget(
                selectedDate: _selectedDate,
                selectedHour: selectedHour,
                selectedMinute: selectedMinute,
                onDateSelected: (date) => setState(() => _selectedDate = date),
                onHourSelected: (hour) => setState(() => selectedHour = hour),
                onMinuteSelected:
                    (minute) => setState(() => selectedMinute = minute),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Seçilen Tarih: $_selectedDate - Saat: $selectedHour:$selectedMinute",
                  style: const TextStyle(color: Colors.teal, fontSize: 16),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Task Oluştur")),
            ],
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
    return TextFormField(
      controller: _taskDescription,
      minLines: 2,
      maxLines: null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: "Görev Açıklamasını Gir",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
    );
  }
}

class TaskHeaderWidget extends StatelessWidget {
  const TaskHeaderWidget({super.key, required this.addTaskNotifier});

  final AddTaskNotifier addTaskNotifier;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => addTaskNotifier.setHour(int.tryParse(value) ?? 0),
      controller: _taskHeader,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: "Görev Başlığı",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
    );
  }
}

class DateTimePickerWidget extends StatefulWidget {
  final DateTime selectedDate;
  final int selectedHour;
  final int selectedMinute;
  final Function(DateTime) onDateSelected;
  final Function(int) onHourSelected;
  final Function(int) onMinuteSelected;

  const DateTimePickerWidget({
    super.key,
    required this.selectedDate,
    required this.selectedHour,
    required this.selectedMinute,
    required this.onDateSelected,
    required this.onHourSelected,
    required this.onMinuteSelected,
  });

  @override
  DateTimePickerWidgetState createState() => DateTimePickerWidgetState();
}

class DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: CalendarTimeline(
            initialDate: widget.selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
            onDateSelected: widget.onDateSelected,
            monthColor: Colors.black,
            dayColor: Colors.black,
            dayNameColor: Colors.black,
            activeDayColor: Colors.white,
            shrink: true,
            activeBackgroundDayColor: Colors.redAccent[100],
            locale: 'en',
          ),
        ),
        SizedBox(width: 5.w),
        Container(
          width: 2,
          height: 80.h,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
        ),
        SizedBox(width: 5.w),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  _buildWheelPicker(
                    List.generate(24, (index) => index),
                    widget.onHourSelected,
                    widget.selectedHour,
                  ),
                  Text(":", style: TextStyle(fontSize: 15.h)),
                  _buildWheelPicker(
                    List.generate(60, (index) => index),
                    widget.onMinuteSelected,
                    widget.selectedMinute,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWheelPicker(
    List<int> items,
    Function(int) onSelected,
    int selectedItem,
  ) {
    return SizedBox(
      width: 45.w,
      height: 80.h,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 35,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => onSelected(items[index]),
        childDelegate: ListWheelChildLoopingListDelegate(
          children:
              items
                  .map(
                    (e) => Center(
                      child: Text("$e", style: TextStyle(fontSize: 16.h)),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}

List categoryList = ["Kişisel", "Okul", "İş", "Alışveriş", "Ev", "Diğer"];

class CategorySelectionWidget extends StatelessWidget {
  final WidgetRef ref;
  final int selectedCategoryId;
  final List<String> categoryList;
  final Function(int) onCategorySelected;

  const CategorySelectionWidget({
    super.key,
    required this.ref,
    required this.selectedCategoryId,
    required this.categoryList,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final isSelected = selectedCategoryId == index;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(90.w, 10.h),
                backgroundColor:
                    isSelected ? Colors.redAccent[100] : Colors.grey,
                foregroundColor: isSelected ? Colors.white : Colors.black,
              ),
              onPressed: () => onCategorySelected(index),
              child: Text(categoryList[index]),
            ),
          );
        },
      ),
    );
  }
}
