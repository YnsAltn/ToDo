import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo/features/auth/presentation/screens/login/provider/login_provider.dart';
import 'package:todo/features/auth/presentation/screens/login/view/login_view.dart';
import 'package:todo/features/home/presentation/screens/settings/provider/settings_provider.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
            leading: Icon(Icons.logout),
            title: Text("Çıkış Yap"),
            onTap: () async {
              _showAlertDialog(context, ref);
            },
          ),
        ],
      ),
    );
  }
}

_showAlertDialog(BuildContext context, WidgetRef ref) {
  final authService = ref.read(authServiceProvider);
  AlertDialog alert = AlertDialog(
    title: Text(
      "Uyarı",
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    ),
    content: Text("Çıkış yapmak istediğinden emin misin?"),
    actions: [
      TextButton(
        child: Text("Hayır"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text("Evet"),
        onPressed: () async {
          await authService.signOut();

          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        },
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
