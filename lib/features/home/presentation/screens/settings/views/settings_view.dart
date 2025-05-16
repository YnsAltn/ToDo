import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo/features/home/presentation/screens/settings/provider/settings_provider.dart';
import 'package:todo/features/home/presentation/widgets/drawer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text("Koyu Mod"),
            trailing: Consumer(
              builder: (context, ref, child) {
                final settings = ref.watch(settingsProvider);
                return Switch(
                  value: settings.isDarkMode,
                  onChanged:
                      (_) =>
                          ref.read(settingsProvider.notifier).toggleDarkMode(),
                );
              },
            ),
          ),

          ListTile(
            leading: Icon(Icons.sync),
            title: Text("Sync Automatically"),
            trailing: Consumer(
              builder: (context, ref, child) {
                final settings = ref.watch(settingsProvider);
                return Switch(
                  value: settings.isSyncOn,
                  onChanged:
                      (_) => ref.read(settingsProvider.notifier).toggleSync(),
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Bildirimler"),
            trailing: Consumer(
              builder: (context, ref, child) {
                final settings = ref.watch(settingsProvider);
                return Switch(
                  value: settings.areNotificationsEnabled,
                  onChanged:
                      (_) =>
                          ref
                              .read(settingsProvider.notifier)
                              .toggleNotifications(),
                );
              },
            ),
          ),

          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.share),
              title: Text("Arkadaşlarınızı Davet Edin"),
            ),
            onTap: () {
              Share.share(
                "Bu kısımda uygulamanın indirme linki olacak veya QR kodu olacak.",
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: DropdownButton<String>(
              value: "EN",
              onChanged: (String? newValue) {},
              items:
                  ["EN", "TR", "DE"]
                      .map(
                        (lang) =>
                            DropdownMenuItem(value: lang, child: Text(lang)),
                      )
                      .toList(),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Delete Account"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
