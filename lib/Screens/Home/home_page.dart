import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:provider/provider.dart';
import '../drawer/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromRGBO(239, 238, 238, 1.0),
            automaticallyImplyLeading: false,
            title: Container(
              margin: EdgeInsets.only(left: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(provider.changeTitleNews(),style:const TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 25,fontWeight: FontWeight.bold),),
                  const Text(' News',style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0),fontSize: 25,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu_rounded,color: Color.fromRGBO(0, 31, 194, 1.0),size: 35,),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          drawer: DrawerWidget(),

          body: provider.chosenIndexWidget(),

          bottomNavigationBar: BottomNavigationBar(
            onTap: (i){
              provider.chosenIndex=i;
              if (i == 0){
                provider.getIndex(0);
              }else if(i == 1){
                provider.getIndex(1);
              }else if(i ==2){
                provider.getIndex(2);
              }else if(i == 3){
                provider.getIndex(3);
              }
            },
            currentIndex: provider.chosenIndex,
            items: const [
              BottomNavigationBarItem(
                icon:Icon(Icons.newspaper_rounded,size: 35,),
                label: 'Breaking',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.public,size: 35,),
                label: 'Popular',
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.explore_rounded,size: 35,),
                  label: 'Discover'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.search,size: 35,),
                  label: 'Search'
              ),
            ],
            selectedItemColor: Color.fromRGBO(0, 31, 194, 1.0),
            unselectedItemColor: Colors.grey,
            backgroundColor: Color.fromRGBO(239, 238, 238, 1.0),
          ),

        );
      }
    );
  }
}
