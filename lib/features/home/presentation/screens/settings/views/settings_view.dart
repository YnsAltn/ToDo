import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo/features/auth/presentation/screens/login/provider/login_provider.dart';
import 'package:todo/features/auth/presentation/screens/login/view/login_view.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profil'),
            onTap: () {
              // TODO: Profil sayfasına yönlendir
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Bildirimler'),
            onTap: () {
              // TODO: Bildirim ayarları sayfasına yönlendir
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Gizlilik'),
            onTap: () {
              // TODO: Gizlilik ayarları sayfasına yönlendir
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Yardım'),
            onTap: () {
              // TODO: Yardım sayfasına yönlendir
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Hakkında'),
            onTap: () {
              // TODO: Hakkında sayfasına yönlendir
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
            onTap: () => _showAlertDialog(context, ref),
          ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Uyarı",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: const Text("Çıkış yapmak istediğinizden emin misiniz?"),
        actions: [
          TextButton(
            child: const Text("Hayır"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Evet"),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginView()),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
