import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final selectedIndexProvider = StateNotifierProvider<SelectedIndexNotifier, int>(
  (ref) => SelectedIndexNotifier(),
);

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);

  void setIndexFromLocation(String location) {
    if (location.startsWith('/home')) {
      state = 0;
    } else if (location.startsWith('/add-task')) {
      state = 1;
    } else if (location.startsWith('/profile')) {
      state = 2;
    } else if (location.startsWith('/settings')) {
      state = 3;
    }
  }

  void updateIndex(int index) => state = index;
}

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(selectedIndexProvider.notifier);
    final selectedIndex = ref.watch(selectedIndexProvider);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        notifier.updateIndex(index);
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/add-task');
            break;
          case 2:
            context.go('/profile');
            break;
          case 3:
            context.go('/settings');
            break;
        }
      },
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Görev Ekle'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
      ],
    );
  }
}
