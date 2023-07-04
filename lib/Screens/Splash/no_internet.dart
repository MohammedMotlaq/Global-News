import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Providers/internet_provider.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiProvider,InternetProvider>(
      builder: (context,uiProvider,netProvider,child) {
        return Scaffold(
          body: Container(
            width: 393.w,
            height: 857.h,
            color: uiProvider.splashColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Lottie.asset('assets/animations/noInternet.json',width: 200.w,height: 250.h),
                const Spacer(),
                Text(
                  'There is no internet Connection\nPlease check your connection then retry',
                  style: TextStyle(
                    color: uiProvider.textColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  height: 70.h,
                  width: 180.w,
                  child: RoundedLoadingButton(
                    color:const Color.fromRGBO(119, 0, 0, 1.0),
                    valueColor: uiProvider.textColor,
                    controller: netProvider.btnController,
                    successColor: const Color.fromRGBO(0, 136, 0, 1.0),
                    errorColor: const Color.fromRGBO(143, 1, 1, 1.0),
                    onPressed: () => netProvider.checkInternetConnection(),
                    child: Text(
                      "Retry",
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
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
