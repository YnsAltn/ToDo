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

    final pages = const [
      HomeView(),
      AddNewTaskView(),
      ShoppingListView(),
      AddSpendView(),
      ProfileView(),
    ];

    return Scaffold(
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
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap:
            (index) => ref.read(selectedIndexProvider.notifier).state = index,
        items: [
          _buildNavItem(Icons.home, 'Ana Sayfa', selectedIndex == 0),
          _buildNavItem(Icons.add_task, 'Görev Ekle', selectedIndex == 1),
          _buildNavItem(
            Icons.shopping_bag_outlined,
            'Alışveriş',
            selectedIndex == 2,
          ),
          _buildNavItem(Icons.attach_money, 'Harcama', selectedIndex == 3),
          _buildNavItem(Icons.person, 'Profil', selectedIndex == 4),
        ],
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
        height: 30.h,
        duration: Duration(milliseconds: 1000),
        padding: EdgeInsets.all(5.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, size: isActive ? 28 : 24),
      ),
      label: label,
    );
  }
}
