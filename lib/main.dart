import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/theme/palette.dart';
import 'screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
                      fontWeight: FontWeight.w500, letterSpacing: -0.333333),
                  bodyText2: themeData.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400, letterSpacing: -0.333333))
              .apply(
                fontFamily: "Mark-Pro",
              ),
        ),
        routes: {
          '/': (BuildContext context) => const MainScreen(),
        },
      ),
    );
  }
}
