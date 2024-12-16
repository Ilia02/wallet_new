import 'package:go_router/go_router.dart';
import 'package:wallet_new/features/presentation/main/pages/bybit_settings_page.dart';
import 'package:wallet_new/features/presentation/main/pages/main_page.dart';
import 'package:wallet_new/features/presentation/main/pages/profile_page.dart';
import 'package:wallet_new/features/presentation/main/pages/settings_page.dart';

class AppRouter {
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/bybit',
        builder: (context, state) => const BybitSettingsPage(),
      ),
    ],
  );
}
