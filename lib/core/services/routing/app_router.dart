import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_new/features/presentation/main/pages/bybit_settings_page.dart';
import 'package:wallet_new/features/presentation/main/pages/home_page.dart';
import 'package:wallet_new/features/presentation/main/pages/profile_page.dart';
import 'package:wallet_new/features/presentation/main/pages/settings_page.dart';
import 'package:wallet_new/features/presentation/main/widgets/app_scaffold.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
            routes: [
              GoRoute(
                path: 'bybit',
                builder: (context, state) => const BybitSettingsPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}
