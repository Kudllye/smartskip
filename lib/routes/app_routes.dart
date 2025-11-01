import 'package:flutter/material.dart';
import '../presentation/main_dashboard/main_dashboard.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/permission_guide_screen/permission_guide_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String mainDashboard = '/main-dashboard';
  static const String splash = '/splash-screen';
  static const String settings = '/settings-screen';
  static const String permissionGuide = '/permission-guide-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    mainDashboard: (context) => const MainDashboard(),
    splash: (context) => const SplashScreen(),
    settings: (context) => const SettingsScreen(),
    permissionGuide: (context) => const PermissionGuideScreen(),
    // TODO: Add your other routes here
  };
}
