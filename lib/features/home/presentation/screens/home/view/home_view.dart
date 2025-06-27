import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/home/presentation/screens/add_spend/provider/add_spend_provider.dart';
import 'package:todo/home.dart';

var now = DateTime.now();
var year = now.year;
var month = now.month;
var day = now.day;
var hour = now.hour;
var minute = now.minute;
var weekday = now.weekday;

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DateWidget(),
            TasksWidget(),
            ShopingWidget(),
            SpendsWidget(),
          ],
        ),
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: SizedBox(
        height: 100.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$day ${getMonthName(month)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  getDayName(weekday),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 30.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Merhaba",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "Yunus",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Bugün seni bekleyen 4 görevin var.",
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TasksWidget extends ConsumerWidget {
  const TasksWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: ListTile(
              title: Text(
                "Bugün yapılacaklar.",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Bugün için planlanmış 4 adet görevin var."),
              trailing: Icon(Icons.task, size: 30.r),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopingWidget extends ConsumerWidget {
  const ShopingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: ListTile(
              title: Text(
                "Alışveriş Listen.",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.shopping_cart, size: 30.r),
              subtitle: Text("Tamamlanmamış alışverişin var."),
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = 2;
                // bu kısımda direkt statteki navigationar indexini değiştirerek sayfanın değişmesini sağladık.
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpendsWidget extends ConsumerWidget {
  const SpendsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spendsAsync = ref.watch(addSpendProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          spendsAsync.when(
            data: (spendList) {
              final totalSpend = spendList.fold<double>(
                0.0,
                (sum, item) => sum + item.spendMoney,
              );
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: ListTile(
                  title: Text(
                    "Harcamalarım.",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.money, size: 30.r),
                  subtitle: Text(
                    "Şubat ayının toplam harcaması: ${totalSpend.toStringAsFixed(2)} ₺",
                  ),
                  onTap: () {
                    ref.read(selectedIndexProvider.notifier).state = 3;
                    // bu kısımda direkt statteki navigationar indexini değiştirerek sayfanın değişmesini sağladık.
                  },
                ),
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (e, _) => Text("Harcama verisi alınamadı: $e"),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(onPressed: () {}, child: Text("Detaylara Git")),
        ],
      ),
    );
  }
}

String getMonthName(int month) {
  const months = [
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
  return months[month - 1];
}

String getDayName(int weekday) {
  const weekdays = [
    "Pazar",
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
  ];
  return weekdays[weekday - 1];
}
