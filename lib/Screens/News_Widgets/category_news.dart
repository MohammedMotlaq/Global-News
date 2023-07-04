import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/news_provider.dart';
import '../../Providers/ui_provider.dart';
import '../WebView/web_view_page.dart';

class CategoryNews extends StatelessWidget {
  String nameCat;
  CategoryNews({Key? key, required this.nameCat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<UiProvider,NewsProvider, DbProvider>(
      builder: (context,uiProvider,newsProvider,dbProvider,x) {
        return Scaffold(
          backgroundColor: uiProvider.scaffoldColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: uiProvider.appBarColor,
            title: Text(nameCat, style: TextStyle(color: uiProvider.primaryColor, fontSize: 25),),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded,color: uiProvider.primaryColor,size: 25,)
            ),
          ),
          body: newsProvider.discoverNews.isEmpty
              ? const Center(
                child: CircularProgressIndicator(color: Colors.grey,),
              )
              : ListView.builder(
                itemCount: newsProvider.discoverNews.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          // var url = Uri.parse(newsProvider.discoverNews[index].url!);
                          // try {
                          //   await canLaunchUrl(url)
                          //     ? await launchUrl(url)
                          //     : throw 'Could not open URL';
                          // } catch (e) {
                          //   log(e.toString());
                          // }
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  WebViewPage(newsURL: newsProvider.discoverNews[index].url!,)));
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
                                    imageUrl: newsProvider.discoverNews[index].urlToImage ?? "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                    errorWidget: (context, url, error) =>
                                      Image.network(
                                        "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                        fit: BoxFit.fill,
                                      ),
                                    placeholder: (context, url) {
                                      return const Center(
                                        child: CircularProgressIndicator(color: Colors.grey,),
                                      );
                                    }
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text(
                                    newsProvider.discoverNews[index].title ?? 'no title', style: TextStyle(fontSize: 18,color: uiProvider.textColor, fontWeight: FontWeight.bold,),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Text(
                                        "Published At: ${newsProvider.discoverNews[index].publishedAt?.substring(0, 10) ?? 'UnKnown'}",
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
                                              if (newsProvider.discoverNews[index].id == null) {
                                                dbProvider.insertFavoriteNews(newsProvider.discoverNews[index]);
                                              } else {
                                                bool isFound = false;
                                                dbProvider.favoritesNews.forEach((element) {
                                                  if (element.id == newsProvider.discoverNews[index].id) {
                                                    isFound = true;
                                                    return;
                                                  }
                                                });
                                                if (isFound) {
                                                  dbProvider.deleteNews(newsProvider.discoverNews[index].id!);
                                                } else {
                                                  dbProvider.insertFavoriteNews(newsProvider.discoverNews[index]);
                                                }
                                              }
                                            },
                                            child: Provider.of<UiProvider>(context).checkFav(newsProvider.discoverNews[index])
                                              ? Image.asset(
                                              'assets/icons/lovered.png',
                                              width: 28.w,
                                              height: 28.h,
                                            )
                                              : Image.asset(
                                              uiProvider.loveIconColor,
                                              width: 28.w,
                                              height: 28.h,
                                            )
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await Share.share(newsProvider.discoverNews[index].url ?? 'no Link');
                                            },
                                            child: Image.asset(
                                              uiProvider.shareIcon,
                                              width: 28.w,
                                              height: 28.h,
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
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
