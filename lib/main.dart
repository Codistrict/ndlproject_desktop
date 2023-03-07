// ignore_for_file: todo
import 'package:flutter/material.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global_var.dart';
import 'pages/auth/ui_auth.dart';
import 'pages/home/ui_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserAuth(),
        )
      ],
      child: MaterialApp(
        title: "NDL Project",
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 2460,
          minWidth: 480,
          defaultScale: false,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 0.8),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K", scaleFactor: 0.8)
          ],
          background: Container(
            color: surfaceColor,
          ),
        ),
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            color: secondaryColor,
            shadowColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 100,
          ),
          primaryColor: secondaryColor,
        ),
        home: const MyApp(),
      ),
    ),
  );
}

class UserAuth with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(val) {
    _isLoggedIn = val;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future getPref() async {
    final prefs = await SharedPreferences.getInstance();
    userStatus = prefs.getBool('userStatus') ?? false;
    userID = prefs.getString('userID') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<UserAuth>().isLoggedIn) {
      debugPrint("${context.watch<UserAuth>().isLoggedIn}");
      return const HomePage();
    } else {
      debugPrint("${context.watch<UserAuth>().isLoggedIn}");
      // return const LoginRegisPage();
      return const HomePage();
    }
  }
}
