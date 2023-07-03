import 'package:news_app/Providers/db_provider.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../WebView/web_view_page.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewsProvider, DbProvider,UiProvider>(
      builder: (context, provider, dbProvider,uiProvider, x) {
        return provider.breakingNews.isEmpty
          ? const Center(
            child: CircularProgressIndicator(color: Colors.grey,),
          )
          : ListView.builder(
            itemCount: provider.breakingNews.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: ()  {
                      // var url = Uri.parse(provider.breakingNews[index].url!);
                      // try {
                      //   await canLaunchUrl(url)
                      //     ? await launchUrl(url, mode: LaunchMode.inAppWebView)
                      //     : throw 'Could not open URL';
                      // } catch (e) {}
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  WebViewPage(newsURL: provider.breakingNews[index].url!,)));
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
                                imageUrl: provider.breakingNews[index].urlToImage ?? "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                errorWidget: (context, url, error) =>
                                  Image.network("https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc", fit: BoxFit.fill,),
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
                                provider.breakingNews[index].title ?? 'no title',
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
                            "Published At: ${provider.breakingNews[index].publishedAt?.substring(11, 16) ?? 'UnKnown'}",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
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
                                  if (provider.breakingNews[index].id == null) {
                                    dbProvider.insertFavoriteNews(provider.breakingNews[index]);
                                  } else {
                                  bool isFound = false;
                                  dbProvider.favoritesNews.forEach((element) {
                                    if (element.id == provider.breakingNews[index].id) {
                                      isFound = true;
                                      return;
                                    }
                                  });
                                    if (isFound) {
                                      dbProvider.deleteNews(provider.breakingNews[index].id!);
                                    } else {
                                      dbProvider.insertFavoriteNews(provider.breakingNews[index]);
                                    }
                                  }
                                },
                                child: Provider.of<UiProvider>(context).checkFav(provider.breakingNews[index])
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
                                  await Share.share(provider.breakingNews[index].url ?? 'no Link');
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
          );
      }
    );
  }
}
