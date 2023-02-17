import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/utils/theme_utils.dart';
import 'screens/export_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeUtils.lightTheme,
        home: const HomePage(),
      );
    },
  ));
}
