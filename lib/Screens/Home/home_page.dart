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
      builder: (context,uiProvider,x) {
        return Scaffold(
          backgroundColor: uiProvider.scaffoldColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: uiProvider.appBarColor,
            automaticallyImplyLeading: false,
            title: Container(
              margin: EdgeInsets.only(left: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(uiProvider.changeTitleNews(),style: TextStyle(color: uiProvider.premaryColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  Text(' News',style: TextStyle(color: uiProvider.premaryColor,fontSize: 25,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu_rounded,color: uiProvider.premaryColor,size: 35,),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          drawer: DrawerWidget(),

          body: SizedBox(
            height: 699.h,
            child: uiProvider.chosenIndexWidget(),
          ),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: (i){
              uiProvider.chosenIndex=i;
              if (i == 0){
                uiProvider.getIndex(0);
              }else if(i == 1){
                uiProvider.getIndex(1);
              }else if(i ==2){
                uiProvider.getIndex(2);
              }else if(i == 3){
                uiProvider.getIndex(3);
              }
            },
            currentIndex: uiProvider.chosenIndex,
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
            selectedLabelStyle:const TextStyle(
              fontWeight: FontWeight.bold
            ),
            backgroundColor: uiProvider.bottomNavColor,
            selectedItemColor: uiProvider.selectedItem,
            unselectedItemColor: Colors.grey,
          ),

        );
      }
    );
  }
}
