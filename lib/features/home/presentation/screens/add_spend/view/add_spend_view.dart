import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/home/presentation/screens/add_spend/model/add_spend_model.dart';
import 'package:todo/features/home/presentation/screens/add_spend/provider/add_spend_provider.dart';
import 'package:intl/intl.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => '');
final moneyController = TextEditingController();
final headController = TextEditingController();
final String spendDate = "";
final String spendDescription = "";

class AddSpendView extends ConsumerWidget {
  const AddSpendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spendsAsync = ref.watch(addSpendProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed:
            () => showDialog(
              context: context,
              builder: (context) => const AddSpendDialog(),
            ),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const SpendPieChart(),
            SizedBox(height: 30.h),
            const SpendingByMonth(),
            SizedBox(height: 5.h),
            spendsAsync.when(
              data:
                  (spends) => Column(
                    children:
                        spends
                            .map(
                              (e) => Card(
                                color: Colors.red[50],
                                child: ListTile(
                                  title: Text(e.spendHead),
                                  subtitle: Text(
                                    "${e.spendCategory.toUpperCase()} - ${e.spendDate}",
                                  ),
                                  trailing: Text(
                                    "₺${e.spendMoney.toStringAsFixed(2)}",
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Hata: $err")),
            ),
          ],
        ),
      ),
    );
  }
}

class AddSpendDialog extends ConsumerWidget {
  const AddSpendDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);
    return AlertDialog(
      title: Text('Harcama Ekle', style: TextStyle(fontSize: 18.sp)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: headController,
              decoration: const InputDecoration(
                labelText: 'Harcama sebebi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: moneyController,
              decoration: const InputDecoration(
                labelText: 'Tutar',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text("Kategori:", style: TextStyle(fontSize: 16.sp)),
                const SizedBox(width: 12),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    ref.read(selectedCategoryProvider.notifier).state = value;
                  },
                  itemBuilder:
                      (_) =>
                          spendCategory
                              .map(
                                (e) => PopupMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selected.isEmpty ? 'Seç' : selected,
                          style: const TextStyle(color: Colors.teal),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("İptal"),
          onPressed: () {
            Navigator.pop(context);
            moneyController.clear();
            headController.clear();
          },
        ),
        ElevatedButton(
          // bu kısıma herhangi bir input alanının boş geçilemeyeceği hakkında kontroller yapılacak
          onPressed: () async {
            final spend = AddSpendModel(
              spendId: Random().nextInt(1 << 32),
              spendMoney: double.parse(moneyController.text),
              spendDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
              spendCategory: ref.read(selectedCategoryProvider),
              spendHead: headController.text,
              spendDescription: spendDescription,
            );
            await ref.read(addSpendProvider.notifier).addSpend(spend);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Harcamalar başarıyla kaydedildi")),
            );
            Navigator.pop(context);
            moneyController.clear();
            headController.clear();
          },
          child: const Text("Ekle"),
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
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: month.length,
        itemBuilder:
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(month[index], style: TextStyle(fontSize: 12.sp)),
              ),
            ),
      ),
    );
  }
}

final Map<String, double> expenses = {
  "Yemek": 500,
  "Ulaşım": 300,
  "Eğlence": 50,
  "Fatura": 700,
  "Yemsdek": 500,
  "sdsds": 300,
  "Eğlsdsdence": 50,
  "Fatusdsra": 700,
};
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

List<String> month = [
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

class SpendPieChart extends ConsumerWidget {
  const SpendPieChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spendsAsync = ref.watch(addSpendProvider);
    double total = 0;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 300,
          child: PieChart(
            PieChartData(
              sections: spendsAsync.when(
                data: (spends) {
                  if (spends.isEmpty) return [];
                  total = spends.fold<double>(
                    0,
                    (sum, e) => sum + e.spendMoney,
                  );
                  return spends.asMap().entries.map((entry) {
                    final e = entry.value;
                    return PieChartSectionData(
                      title:
                          "${e.spendCategory}\n₺${e.spendMoney.toStringAsFixed(2)}",
                      value: e.spendMoney,
                      color:
                          Colors.primaries[entry.key % Colors.primaries.length],
                      radius: 80,
                      titleStyle: TextStyle(fontSize: 12.sp),
                    );
                  }).toList();
                },
                loading: () => [],
                error: (err, stack) => [],
              ),
              centerSpaceRadius: 90,
              sectionsSpace: 3,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              "Toplam Harcama",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "₺$total",
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
