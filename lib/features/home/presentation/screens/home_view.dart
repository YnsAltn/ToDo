import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/home/presentation/widgets/drawer.dart';

var now = DateTime.now();
var year = now.year;
var month = now.month;
var day = now.day;
var hour = now.hour;
var minute = now.minute;
var second = now.second;
var weekday = now.weekday;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black, size: 30.r),
            onPressed: () {},
          ),
        ],
        toolbarHeight: 50.h,
        leading: IconButton(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
            size: 40.r,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text("Todo App"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: DrawerCard(),
      body: Column(children: [DateWidget(), TasksWidget()]),
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
                    fontSize: 25.sp,
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

class TasksWidget extends StatelessWidget {
  const TasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.h),
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
          SizedBox(height: 10.h),

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
              subtitle: Text("Tamamlanmamış Alışverişin var."),
            ),
          ),
          SizedBox(height: 10.h),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: ListTile(
              title: Text(
                "Harcamalarım.",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.money, size: 30.r),
              subtitle: Text("Bu ayki toplam harcaman 2000 TL."),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.push("/register");
            },
            child: Text("data"),
          ),
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
