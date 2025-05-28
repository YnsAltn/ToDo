import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/auth/presentation/screens/login/provider/login_provider.dart';
import 'package:todo/features/auth/presentation/screens/login/view/login_view.dart';

final agreementProvider = StateProvider<bool>((ref) => false);

class RegisterView extends ConsumerWidget {
  RegisterView({super.key});

  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 200.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Kayıt Ol",
                            style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabını Oluştur",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "E-posta",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController1,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController2,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListTile(
                    title: Text("Sözleşmeyi kabul ediyorum"),
                    leading: Switch(
                      value: ref.watch(agreementProvider),
                      onChanged:
                          (value) =>
                              ref.read(agreementProvider.notifier).state =
                                  value,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(320.w, 45.h),
                      backgroundColor: Colors.grey,
                    ),
                    onPressed:
                        () => _doRegister(
                          context,
                          ref,
                          passwordController1,
                          passwordController2,
                          emailController,
                        ),
                    child: Text(
                      "KAYIT OL",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _doRegister(
  BuildContext context,
  WidgetRef ref,
  dynamic passwordController1,
  dynamic passwordController2,
  dynamic emailController,
) async {
  final email = emailController.text.trim();
  final pass1 = passwordController1.text.trim();
  final pass2 = passwordController2.text.trim();

  if (email.isEmpty || pass1.isEmpty || pass2.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Lütfen tüm alanları doldurun.")));
    return;
  }

  if (pass1 != pass2) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Şifreler aynı olmalı.")));
    return;
  }
  final authService = ref.read(authServiceProvider);

  try {
    await authService.createUser(email: email, password: pass1);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Kayıt başarısız.")));
  }
}
