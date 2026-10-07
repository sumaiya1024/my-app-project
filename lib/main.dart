import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/splash_screen.dart'; // স্প্ল্যাশ স্ক্রিন ফাইলটি সঠিক ফোল্ডার থেকে ইম্পোর্ট করা হলো
import 'screens/role_selection_screen.dart';

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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const Splashscreen(),
    );
  }
}
