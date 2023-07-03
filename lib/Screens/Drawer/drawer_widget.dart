import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/ui_provider.dart';
import 'favorite_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    openWhatsapp() async{
      Uri emailURL =Uri.parse("mailto:mohammedmotlaq32@gmail.com");
      if( await canLaunchUrl(emailURL)){
        await launchUrl(emailURL);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please, Install an Email App...",style: TextStyle(fontSize: 12),))
        );
      }
    }
    return Consumer<UiProvider>(
      builder: (context,uiProvider,x) {
        return Container(
          width: 300.w,
          color: uiProvider.drawerBackgroundColor,
          child: Column(
            children: [
              SizedBox(
                width: 300.w,
                height: 250.h,
                child:Column(
                  children: [
                    const Spacer(),
                    Image.asset('assets/images/splashScreen.png',width: 150,height: 150,),
                    Text(
                      "Discover Breaking Stories\n      on our News App!",
                      style: TextStyle(
                          color: uiProvider.textColor,
                          fontSize: 17.sp,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:uiProvider.textButtonDrawer
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return const FavoriteScreen();
                    }));
                  },
                  child: SizedBox(
                    height: 35.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icons/lovered.png', width: 30.w, height: 30.h,),
                            Text('   Favorites',style: TextStyle(color: uiProvider.textColor,fontSize: 17,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,color:uiProvider.textColor,size: 20,)
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 0.5,
                indent: 8.w,
                endIndent: 8.w,
                color: Colors.grey.shade500,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:uiProvider.textButtonDrawer
                  ),
                  onPressed: ()async{
                    uiProvider.changeIsDark();
                  },
                  child: SizedBox(
                    height: 35.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              uiProvider.darkIcon,
                              width: 30.w,
                              height: 30.h,
                            ),
                            Text(uiProvider.mode,style: TextStyle(color: uiProvider.textColor,fontSize: 17,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Switch(
                          activeColor: Colors.red,
                          value: uiProvider.themeColor,
                          onChanged: (bool newValue) {
                            uiProvider.changeIsDark();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 0.5,
                indent: 8.w,
                endIndent: 8.w,
                color: Colors.grey.shade500,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:uiProvider.textButtonDrawer
                  ),
                  onPressed: ()async{
                    Navigator.pop(context);
                    await openWhatsapp();
                  },
                  child: SizedBox(
                    height: 35.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              uiProvider.agentIcon,
                              width: 30.w,
                              height: 30.h,
                            ),
                            Text('   Contact Us',style: TextStyle(color: uiProvider.textColor,fontSize: 17,fontWeight: FontWeight.bold),)
                          ],
                        ),
                         Icon(Icons.arrow_forward_ios_rounded,color:uiProvider.textColor,size: 20,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
