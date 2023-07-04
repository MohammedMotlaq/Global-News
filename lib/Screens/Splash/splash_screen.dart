import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:news_app/screens/home/home_page.dart';
import 'package:provider/provider.dart';

import 'no_internet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2),() async {
      if(await InternetConnectionChecker().hasConnection){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomePage();
        }));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return NoInternet();
        }));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context,uiProvider,child) {
        return Scaffold(
          body: Container(
            color: uiProvider.splashColor,
            width: 393.w,
            height: 857.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/splashScreen.png',
                  width: 250.w,
                  height: 280.h,
                  fit: BoxFit.fill
                ),
                const Spacer(),
                Text(
                  "Discover Breaking Stories\n      on our News App!",
                  style: TextStyle(
                    color: uiProvider.textColor,
                    fontSize: 28.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.red.withOpacity(0.5),
                        offset: const Offset(3,4),
                        blurRadius: 7
                      ),
                      const Shadow(
                          color: Color.fromRGBO(106, 0, 0, 0.8),
                          offset: Offset(5,6),
                          blurRadius: 7
                      )
                    ]
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      }
    );
  }
}
