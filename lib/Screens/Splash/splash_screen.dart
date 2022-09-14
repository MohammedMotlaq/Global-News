import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/screens/home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState(){
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
        return HomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393.w,
      height: 857.h,
      child: Image.asset('assets/images/splashScreen.png',width: 450.w,height: 829.h,fit: BoxFit.fill,),
    );
  }
}
