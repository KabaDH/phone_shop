import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_shop/theme/palette.dart';
import 'screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ProviderScope(
        child: ScreenUtilInit(
      designSize: const Size(414, 951),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: Colors.grey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Palette.scaffoldBackground,
            primaryColor: Palette.primaryColor,
            textTheme: themeData.textTheme
                .copyWith(
                    headline5: themeData.textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.w800, letterSpacing: -0.333333),
                    subtitle1: themeData.textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w700, letterSpacing: -0.333333),
                    bodyText1: themeData.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, letterSpacing: -0.12),
                    bodyText2: themeData.textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w400, letterSpacing: -0.333333))
                //     headline5: themeData.textTheme.headline5?.copyWith(
                // fontWeight: FontWeight.w800, letterSpacing: -0.333333),
                //   subtitle1: themeData.textTheme.subtitle1?.copyWith(
                //       fontWeight: FontWeight.w700, letterSpacing: -0.333333),
                //   bodyText1: themeData.textTheme.bodyText1?.copyWith(
                //       fontWeight: FontWeight.w500, letterSpacing: -0.12),
                //   bodyText2: themeData.textTheme.bodyText2?.copyWith(
                //       fontWeight: FontWeight.w400, letterSpacing: -0.333333))
                .apply(
                  fontFamily: "Mark-Pro",
                ),
          ),
          routes: {
            '/': (BuildContext context) => const MainScreen(),
            '/product_details': (BuildContext context) => const ProductDetails(),
            '/cart': (BuildContext context) => const MyCart(),
          },
        );
      },
    ));
  }
}
