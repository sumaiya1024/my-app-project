import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/splash_screen.dart';
import 'constants.dart'; // গ্লোবাল কালার ব্যবহারের জন্য
import 'theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ThemeManager.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeModeNotifier,
      builder: (context, currentThemeMode, _) {
        return MaterialApp(
          title: 'Kinvera - Elderly Care',
          debugShowCheckedModeBanner: false,
          themeMode: currentThemeMode,
          // লাইট থিম কনফিগারেশন
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: AppColors.primaryTeal,
            scaffoldBackgroundColor: AppColors.backgroundColor,
            cardColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryTeal,
              primary: AppColors.primaryTeal,
              secondary: AppColors.lightTeal,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primaryTeal,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
          ),
          // ডার্ক থিম কনফিগারেশন
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: AppColors.lightTeal,
            scaffoldBackgroundColor: AppColors.darkBackground,
            cardColor: AppColors.darkCard,
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.darkCard,
            ),
            canvasColor: AppColors.darkCard,
            drawerTheme: const DrawerThemeData(
              backgroundColor: AppColors.darkCard,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryTeal,
              primary: AppColors.lightTeal,
              secondary: AppColors.primaryTeal,
              surface: AppColors.darkCard,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF131D24),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const SplashScreen(),
        );
      },
    );
  }
}
