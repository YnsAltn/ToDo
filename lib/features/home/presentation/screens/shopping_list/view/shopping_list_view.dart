import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/home/presentation/widgets/drawer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final selectedIndexProvider = StateProvider<int>((ref) => 0);
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItem>>(
      (ref) => ShoppingListNotifier(),
    );

class ShoppingItem {
  final String name;
  final bool isChecked;

  ShoppingItem({required this.name, this.isChecked = false});

  ShoppingItem copyWith({String? name, bool? isChecked}) {
    return ShoppingItem(
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

class ShoppingListNotifier extends StateNotifier<List<ShoppingItem>> {
  ShoppingListNotifier() : super([]);

  void addItem(String name) {
    state = [...state, ShoppingItem(name: name)];
  }

  void toggleItem(int index) {
    final updated = state[index].copyWith(isChecked: !state[index].isChecked);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updated else state[i],
    ];
  }
}

class ShoppingListView extends ConsumerWidget {
  const ShoppingListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(shoppingListProvider);
    final controller = TextEditingController();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Ürün adı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      ref
                          .read(shoppingListProvider.notifier)
                          .addItem(controller.text.trim());
                      controller.clear();
                    }
                  },
                  child: const Text('Ekle'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(
                      decoration:
                          item.isChecked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: item.isChecked,
                    onChanged:
                        (_) => ref
                            .read(shoppingListProvider.notifier)
                            .toggleItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
