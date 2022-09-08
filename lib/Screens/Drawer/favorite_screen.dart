import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/db_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiProvider,DbProvider>(
      builder: (context,uiProvider,dbProvider,x) {
        return Scaffold(
          backgroundColor: uiProvider.scaffoldColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: uiProvider.appBarColor,
            title: Text('Favorites',style: TextStyle(color: uiProvider.premaryColor, fontSize: 25),),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded,color: uiProvider.premaryColor,size: 25,)
            ),
          ),
          body: dbProvider.favoritesNews.isEmpty
            ? Center(
              child: Lottie.asset('assets/animations/empty.json',width: 350.w,height: 500.h),
            )
            : ListView.builder(
              itemCount: dbProvider.favoritesNews.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse(dbProvider.favoritesNews[index].url!);
                        try {
                          await canLaunchUrl(url)
                            ? await launchUrl(url,
                              mode: LaunchMode.inAppWebView)
                            : throw 'Could not open URL';
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  width: 380.w,
                                  height: 200.h,
                                  fit: BoxFit.fill,
                                  imageUrl: dbProvider.favoritesNews[index].urlToImage ?? "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                  errorWidget: (context, url, error) =>
                                    Image.network(
                                      "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                      fit: BoxFit.fill,
                                    ),
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    );
                                  }
                                ),
                              ),
                              Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  dbProvider.favoritesNews[index].title ?? 'no title',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: uiProvider.textColor
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              "Published At: ${dbProvider.favoritesNews[index].publishedAt?.substring(0, 10) ?? 'UnKnown'}",
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                          Container(
                            width: 80.w,
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    dbProvider.deleteNews(dbProvider.favoritesNews[index].id!);
                                  },
                                  child: Image.asset(
                                    'assets/icons/lovered.png',
                                    width: 28.w,
                                    height: 28.h,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Share.share(dbProvider.favoritesNews[index].url ?? 'no Link');
                                  },
                                  child: Image.asset(
                                    uiProvider.shareIcon,
                                    width: 28.w,
                                    height: 28.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: uiProvider.lineColor,
                      indent: 0,
                      endIndent: 0,
                      thickness: 6,
                      height: 4,
                    ),
                  ],
                );
              }
            ),
        );
      }
    );
  }
}