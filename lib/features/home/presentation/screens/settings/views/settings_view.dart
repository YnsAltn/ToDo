import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo/features/home/components/bottom_navigationbar.dart';
import 'package:todo/features/home/presentation/screens/settings/provider/settings_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
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
