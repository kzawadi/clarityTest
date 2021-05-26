import 'package:clarity/UIv2/theme/theme.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/app/app.router.dart';
import 'package:clarity/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  // setupDialogUi();
  // setupBottomSheetUi();
  // maybeStartFGS();
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: KColors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.nunito(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clarity',
        theme: AppTheme.lightTheme,
        // ThemeData(
        //   appBarTheme: const AppBarTheme(backgroundColor: KColors.background),
        //   scaffoldBackgroundColor: KColors.background,
        //   primaryColor: Colors.white,
        //   accentColor: KColors.primary,
        //   iconTheme: const IconThemeData(color: Colors.black),
        //   fontFamily: GoogleFonts.montserrat().fontFamily,
        //   textTheme: GoogleFonts.montserratTextTheme(),
        // ),
        // home: StartUpView(),
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}

// class Palette {
//   //243 240 230  f3 f0 e6
//   static const Color appBackgroundColor = Color(0xffFCFBE1); //F5D9C9
//   static const Color background = Color(0xFFFCFBE1); //DCBFAF
//   static const Color secondaryBackground = Color(0xFFC9C8AE);
//   static const Color green = Color(0xFF2AAF61);
// }
