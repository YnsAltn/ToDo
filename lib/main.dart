import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/auth/presentation/screens/login/view/login_view.dart';
import 'package:todo/features/auth/service/auth_service.dart';
import 'package:todo/features/home/presentation/screens/settings/provider/settings_provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChange = ref.watch(settingsProvider).isDarkMode;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          theme: themeChange ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<bool>(
            future: AuthService.isUserLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data == true) {
                return HomeScreen();
              }

              return LoginView();
            },
          ),
        );
      },
    );
  }
}
