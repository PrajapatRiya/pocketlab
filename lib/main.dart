import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketlab/bottombarscreen/bottombar.dart';
import 'package:pocketlab/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pocket Lab',
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Lato",
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0A0A0C), // Ultra Dark
            
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6366F1), // Electric Indigo
              secondary: Color(0xFF10B981), // Emerald
              surface: Color(0xFF161618), // Deep Zinc
              onSurface: Colors.white,
              onPrimary: Colors.white,
            ),

            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),

            textTheme: TextTheme(
              displayLarge: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.w900),
              headlineMedium: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800),
              titleLarge: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
              bodyLarge: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16.sp, height: 1.5),
              bodyMedium: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.sp),
            ),

            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 56.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                elevation: 8,
                shadowColor: const Color(0xFF6366F1).withOpacity(0.5),
                textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),
            ),

            cardTheme: CardThemeData(
              color: const Color(0xFF161618),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
                side: BorderSide(color: Colors.white.withOpacity(0.05)),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF161618),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              hintStyle: TextStyle(color: Colors.white30, fontSize: 14.sp),
              prefixIconColor: const Color(0xFF6366F1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
              ),
            ),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
