import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentation/screens/login/login_view.dart';
import 'package:todo/features/auth/presentation/screens/register/register_view.dart';
import 'package:todo/features/home/presentation/screens/home_view.dart';
import 'package:todo/features/home/presentation/screens/settings/views/settings_view.dart';
import 'package:todo/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: "/", name: "Home", builder: (context, state) => HomeView()),
    GoRoute(
      path: "/splash",
      name: "SplashView",
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: "/profile",
      name: "ProfileView",
      builder: (context, state) => ProfileView(),
    ),
    GoRoute(
      path: "/login",
      name: "LoginView",
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: "/register",
      name: "RegisterView",
      builder: (context, state) => RegisterView(),
    ),
  ],
);
