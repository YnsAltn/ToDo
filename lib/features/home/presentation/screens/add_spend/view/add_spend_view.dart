import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class AddSpendView extends StatelessWidget {
  const AddSpendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          debugPrint("Butona tıklandı");
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        tooltip: 'Artım',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Harcamalarım")),
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
