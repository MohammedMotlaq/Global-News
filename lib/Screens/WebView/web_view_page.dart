import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key,required this.newsURL});
  final String newsURL;
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const CircularProgressIndicator(color: Colors.grey,);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(newsURL));
    return Consumer<UiProvider>(
      builder: (context,uiProvider,child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: uiProvider.appBarColor,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,color: uiProvider.premaryColor,)
            ),
            title:  Text('Go Back',style: TextStyle(color: uiProvider.premaryColor,fontSize: 25.sp),)
          ),
          body: SizedBox(
            width: 393.w,
              height: 800.h,
              child: WebViewWidget(controller: controller)
          ),
        );
      }
    );
  }
}
