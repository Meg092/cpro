import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotation_clock/pages/cpro_main/cpro_main_binding.dart';
import 'package:rotation_clock/pages/cpro_main/cpro_main_view.dart';
import 'package:rotation_clock/pages/cpro_mode/cpro_mode_binding.dart';
import 'package:rotation_clock/pages/cpro_mode/cpro_mode_view.dart';
import 'package:rotation_clock/pages/cpro_setting/cpro_setting_binding.dart';
import 'package:rotation_clock/pages/cpro_setting/cpro_setting_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = const Color(0xff1d1d1d);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final showWeekDay = prefs.getBool('showWeekDay');
  if (showWeekDay == null) {
    await prefs.setBool('showWeekDay', true);
    await prefs.setBool('showAPM', true);
    await prefs.setBool('autoLandscape', true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: CPro,
      initialRoute: '/cpro_main',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> CPro = [
  GetPage(name: '/cpro_main', page: () => const CproMainView(), binding: CproMainBinding()),
  GetPage(name: '/cpro_setting', page: () => CproSettingView(), binding: CproSettingBinding()),
  GetPage(name: '/cpro_mode', page: () => CproModeView(), binding: CproModeBinding()),
];
