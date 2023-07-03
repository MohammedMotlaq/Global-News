import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/db_provider.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/ui_provider.dart';
import '../WebView/web_view_page.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewsProvider, DbProvider,UiProvider>(
      builder: (context, provider, dbProvider,uiProvider, x) {
        return provider.popularNews.isEmpty
          ? const Center(
            child: CircularProgressIndicator(color: Colors.grey,),
          )
          : ListView.builder(
            itemCount: provider.popularNews.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      // var url = Uri.parse(provider.popularNews[index].url!);
                      // try {
                      //   await canLaunchUrl(url) ? await launchUrl(url) : throw 'Could not open URL';
                      // } catch (e) {
                      //   log(e.toString());
                      // }
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  WebViewPage(newsURL: provider.popularNews[index].url!,)));

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
                                imageUrl: provider.popularNews[index].urlToImage ?? "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                provider.popularNews[index].title ?? 'no title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:  uiProvider.textColor
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: Text(
                                    "Published At: ${provider.popularNews[index].publishedAt?.substring(0, 10) ?? 'UnKnown'}",
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (provider.popularNews[index].id == null) {
                                      dbProvider.insertFavoriteNews(provider.popularNews[index]);
                                    } else {
                                      bool isFound = false;
                                      dbProvider.favoritesNews.forEach((element) {
                                        if (element.id == provider.popularNews[index].id) {
                                          isFound = true;
                                          return;
                                        }
                                      });
                                      if (isFound) {
                                        dbProvider.deleteNews(provider.popularNews[index].id!);
                                      } else {
                                        dbProvider.insertFavoriteNews(provider.popularNews[index]);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 80.w,
                                    margin: EdgeInsets.only(right: 10.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (provider.popularNews[index].id == null) {
                                              dbProvider.insertFavoriteNews(provider.popularNews[index]);
                                            } else {
                                              bool isFound = false;
                                              dbProvider.favoritesNews.forEach((element) {
                                                if (element.id == provider.popularNews[index].id) {
                                                  isFound = true;
                                                  return;
                                                }
                                              });
                                              if (isFound) {
                                                dbProvider.deleteNews(provider.popularNews[index].id!);
                                              } else {
                                                dbProvider.insertFavoriteNews(provider.popularNews[index]);
                                              }
                                            }
                                          },
                                          child: Provider.of<UiProvider>(context).checkFav(provider.popularNews[index])
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
                                            await Share.share(provider.popularNews[index].url ?? 'no Link');
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
          );
      }
    );
  }
}
