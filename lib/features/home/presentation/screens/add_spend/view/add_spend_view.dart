import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/home/presentation/widgets/drawer.dart';

final Map<String, double> expenses = {
  "Yemek": 500,
  "Ulaşım": 300,
  "Eğlence": 50,
  "Fatura": 700,
  "asasa": 500,
  "Ulaşdfdım": 300,
  "Eğlenfce": 50,
  "Faturda": 400,
};
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final selectedCategoryProvider = StateProvider<String>((ref) => '');

class AddSpendView extends ConsumerWidget {
  const AddSpendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            builder: (BuildContext conntext) {
              return SizedBox(
                height: 350.h,
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        "Harcanan Yer",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Harcama sebebini giriniz",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Miktar",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Harcanan miktar",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Text(
                            'Kategori:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Consumer(
                            builder: (context, ref, _) {
                              final selected = ref.watch(
                                selectedCategoryProvider,
                              );
                              return PopupMenuButton<String>(
                                color: Colors.white,
                                onSelected: (value) {
                                  ref
                                      .read(selectedCategoryProvider.notifier)
                                      .state = value;
                                },
                                itemBuilder:
                                    (context) =>
                                        spendCategory
                                            .map(
                                              (e) => PopupMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        selected.isEmpty ? 'Seç' : selected,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.teal,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Ekle",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              );
            },
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Icon(Icons.add),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black, size: 30.r),
            onPressed: () {},
          ),
        ],
        toolbarHeight: 42.h,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 40.r),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text("Todo App"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerCard(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            SpendPieChart(),
            SizedBox(height: 30.h),
            SpendingByMonth(),
            SizedBox(height: 20.h),
            ExpenseListWidget(expenses: expenses),
          ],
        ),
      ),
    );
  }
}

List<String> spendCategory = [
  "yemek",
  "Ev",
  "Okul",
  "Giyim",
  "ulaşım",
  "eğlence",
  "ihtiyaç",
  "diğer",
];
List month = [
  "Ocak",
  "Şubat",
  "Mart",
  "Nisan",
  "Mayıs",
  "Haziran",
  "Temmuz",
  "Ağustos",
  "Eylül",
  "Ekim",
  "Kasım",
  "Aralık",
];

class SpendPieChart extends StatelessWidget {
  const SpendPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    double totalExpense = expenses.values.fold(0, (sum, value) => sum + value);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 300,
          child: PieChart(
            PieChartData(
              sections:
                  expenses.entries.map((entry) {
                    return PieChartSectionData(
                      titleStyle: TextStyle(fontSize: 12.sp),
                      value: entry.value,
                      title: "${entry.key}\n₺${entry.value}",

                      color:
                          Colors.primaries[expenses.keys.toList().indexOf(
                                entry.key,
                              ) %
                              Colors.primaries.length],
                      radius: 80,
                    );
                  }).toList(),
              centerSpaceRadius: 90,
              sectionsSpace: 3,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Toplam Harcama",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "₺$totalExpense",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SpendingByMonth extends StatelessWidget {
  const SpendingByMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: month.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              onPressed: () {},
              child: Text(month[index], style: TextStyle(fontSize: 12.sp)),
            ),
          );
        },
      ),
    );
  }
}

class ExpenseListWidget extends StatelessWidget {
  final Map<String, double> expenses;

  const ExpenseListWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            expenses.entries.map((entry) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.r),
                ),
                color: Colors.red[50],
                shadowColor: Colors.transparent,
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                child: ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.green),
                  title: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "₺${entry.value}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
