import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/AppRouter.dart';
import 'package:news_app/Helpers/sp_helper.dart';
import 'package:news_app/Providers/internet_provider.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'Helpers/database_helper.dart';
import 'Providers/db_provider.dart';
import 'Providers/ui_provider.dart';
import 'Screens/Splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  await SPHelper.initializeSp();
  await SPHelper.setIsDark();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NewsProvider>(create: (context) {
      return NewsProvider();
    }),
    ChangeNotifierProvider<UiProvider>(create: (context) {
      return UiProvider();
    }),
    ChangeNotifierProvider<DbProvider>(create: (context) {
      return DbProvider();
    }),
    ChangeNotifierProvider<InternetProvider>(create: (context) {
      return InternetProvider();
    }),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 857),
        builder: (context, x) {
          return MaterialApp(
            navigatorKey: AppRouter.navKey,
            theme: ThemeData(
              fontFamily: 'Bell MT',
              primarySwatch: Colors.red,
              useMaterial3: true
            ),
            home:const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
