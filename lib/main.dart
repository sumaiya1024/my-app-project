import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/splash_screen.dart';
import 'constants.dart'; // গ্লোবাল কালার ব্যবহারের জন্য

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
    return MaterialApp(
      title: 'Kinvera - Elderly Care',
      debugShowCheckedModeBanner: false,
      // গ্লোবাল থিম কনফিগারেশন (পুরো অ্যাপের কালার ও স্টাইল মেইনটেইন করার জন্য)
      theme: ThemeData(
        primaryColor: AppColors.primaryTeal,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryTeal,
          primary: AppColors.primaryTeal,
          secondary: AppColors.lightTeal,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryTeal,
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
  }
}
