import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/auth/presentation/screens/login/provider/login_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/features/auth/presentation/screens/register/register_view.dart';
import 'package:todo/home.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);

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
                            "Hoş Geldin",
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
                            "Uygulamaya Başlamak için giriş yapmalısın",
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
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "● ● ● ● ● ● ● ●",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed:
                        () => _doLogin(
                          context,
                          emailController.text,
                          passwordController.text,
                          ref,
                        ),
                    child: Text("GİRİŞ"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Şifreni mi unuttun?"),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hesabın yok mu?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      child: Text("Kayıt Ol"),
                    ),
                  ],
                ),
              ],
            ),
            OtherLoginFunction(authService: authService),
          ],
        ),
      ),
    );
  }
}

class OtherLoginFunction extends ConsumerWidget {
  const OtherLoginFunction({super.key, required this.authService});

  final AuthService authService;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _loginWithGoogle(context, ref),
            child: SvgPicture.asset("assets/logos/google.svg"),
          ),
        ],
      ),
    );
  }
}

Future<void> _doLogin(
  BuildContext context,
  String email,
  String password,
  WidgetRef ref,
) async {
  final authService = ref.read(authServiceProvider);
  try {
    final loginModel = await authService.signIn(
      email: email,
      password: password,
    );

    debugPrint("✅ Giriş başarılı! Token: ${loginModel.userToken}");

    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } catch (e) {
    debugPrint("🚨 Giriş hatası: $e");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Hata: $e")));
  }
}

Future _loginWithGoogle(BuildContext context, WidgetRef ref) async {
  final authService = ref.read(authServiceProvider);
  final user = await authService.signInWithGoogle();
  if (!context.mounted) return;
  if (user != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Google doğrulaması başarısız oldu")),
    );
  }
}
