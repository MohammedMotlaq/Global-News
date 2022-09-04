import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'favorite_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
              width: 300.w,
              height: 250.h,
              child: Image.asset('assets/images/newsImage.png',height: 300.h,fit: BoxFit.cover,)
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    primary:const Color.fromRGBO(109, 130, 241, 1.0),
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:const Color.fromRGBO(241, 241, 241, 0.3)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return FavoriteScreen();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:const [
                        Icon(Icons.favorite,color:Color.fromRGBO(204, 1, 1, 1.0),size: 30,),
                        Text('   Favorites',style: TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 17),)
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios,color:Color.fromRGBO(0, 31, 194, 1.0),size: 20,)
                  ],
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    primary:const Color.fromRGBO(109, 130, 241, 1.0),
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:const Color.fromRGBO(241, 241, 241, 0.3)
                ),
                onPressed: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:const [
                        Icon(Icons.bookmark,color:Color.fromRGBO(255, 221, 0, 1.0),size: 30,),
                        Text('   Saved',style: TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 17),)
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios,color:Color.fromRGBO(0, 31, 194, 1.0),size: 20,)
                  ],
                )
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
                    primary:const Color.fromRGBO(109, 130, 241, 1.0),
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:const Color.fromRGBO(241, 241, 241, 0.3)
                ),
                onPressed: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:const [
                        Icon(Icons.dark_mode_outlined,color:Color.fromRGBO(
                            245, 181, 20, 1.0),size: 30,),
                        Text('   Dark Mode',style: TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 17),)
                      ],
                    ),
                    Switch(
                      value: false,
                      onChanged: (bool newValue) {
                        // setState(() {
                        //   giveVerse = newValue;
                        // });
                      },
                    )
                  ],
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    primary:const Color.fromRGBO(109, 130, 241, 1.0),
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:const Color.fromRGBO(241, 241, 241, 0.3)
                ),
                onPressed: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:const [
                        Icon(Icons.notifications_none_outlined,color:Color.fromRGBO(
                            255, 221, 0, 1.0),size: 30,),
                        Text('   Notifications',style: TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 17),)
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios,color:Color.fromRGBO(0, 31, 194, 1.0),size: 20,)
                  ],
                )
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
                    primary:const Color.fromRGBO(109, 130, 241, 1.0),
                    padding:const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:const Color.fromRGBO(241, 241, 241, 0.3)
                ),
                onPressed: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:const [
                        Icon(Icons.help_outline_rounded,color:Color.fromRGBO(255, 221, 0, 1.0),size: 30,),
                        Text('   Help',style: TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 17),)
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios,color:Color.fromRGBO(0, 31, 194, 1.0),size: 20,)
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
