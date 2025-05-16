import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/home/components/bottom_navigationbar.dart';
import 'package:todo/features/home/presentation/screens/add_spend/view/add_spend_view.dart';
import 'package:todo/features/home/presentation/screens/add_task/view/add_task_view.dart';
import 'package:todo/features/home/presentation/screens/home/view/home_view.dart';
import 'package:todo/features/home/presentation/screens/settings/views/settings_view.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeView()),
        GoRoute(
          path: '/add-task',
          builder: (context, state) => const AddNewTaskView(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileView(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const AddSpendView(),
        ),
      ],
    ),
  ],
);
