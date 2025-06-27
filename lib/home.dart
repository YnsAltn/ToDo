import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/home/presentation/screens/add_spend/view/add_spend_view.dart';
import 'package:todo/features/home/presentation/screens/add_task/view/add_task_view.dart';
import 'package:todo/features/home/presentation/screens/home/view/home_view.dart';
import 'package:todo/features/home/presentation/screens/settings/views/settings_view.dart';
import 'package:todo/features/home/presentation/screens/shopping_list/view/shopping_list_view.dart';
import 'package:todo/features/home/presentation/widgets/drawer.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final pages = [
      const HomeView(),
      const AddNewTaskView(),
      const ShoppingListView(),
      const AddSpendView(),
      const SettingsView(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 24.r,
            ),
            onPressed: () {
              // TODO: Bildirimler sayfasına yönlendir
            },
          ),
          SizedBox(width: 8.w),
        ],
        toolbarHeight: 56.h,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 24.r),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          "Todo App",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      drawer: const DrawerCard(),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          currentIndex: selectedIndex,
          onTap:
              (index) => ref.read(selectedIndexProvider.notifier).state = index,
          items: [
            _buildNavItem(Icons.home_outlined, 'Ana Sayfa', selectedIndex == 0),
            _buildNavItem(
              Icons.add_task_outlined,
              'Görev Ekle',
              selectedIndex == 1,
            ),
            _buildNavItem(
              Icons.shopping_bag_outlined,
              'Alışveriş',
              selectedIndex == 2,
            ),
            _buildNavItem(
              Icons.attach_money_outlined,
              'Harcama',
              selectedIndex == 3,
            ),
            _buildNavItem(
              Icons.settings_outlined,
              'Ayarlar',
              selectedIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
  ) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        height: 40.h,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          size: isActive ? 24.r : 22.r,
          color: isActive ? Colors.teal : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
