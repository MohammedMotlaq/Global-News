import 'dart:developer';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:news_app/Helpers/database_helper.dart';

import 'package:news_app/Providers/db_provider.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/news_provider.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<NewsProvider, DbProvider>(
        builder: (context, provider, dbProvider, x) {
      return provider.news.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            )
          : ListView.builder(
              itemCount: provider.news.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        var url = Uri.parse(provider.news[index].url!);
                        try {
                          await canLaunchUrl(url)
                              ? await launchUrl(url,
                                  mode: LaunchMode.inAppWebView)
                              : throw 'Could not open URL';
                        } catch (e) {}
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
                                    imageUrl: provider.news[index].urlToImage ??
                                        "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
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
                                    }),
                              ),
                              Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  provider.news[index].title ?? 'no title',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              "Published At: ${provider.news[index].publishedAt?.substring(11, 16) ?? 'UnKnown'}",
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  color: Colors.grey,
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
                                      if (provider.news[index].id == null)
                                        dbProvider.insertFavoriteNews(
                                            provider.news[index]);
                                      else {
                                        bool isfound = false;
                                        dbProvider.favoritesNews
                                            .forEach((element) {
                                          if (element.id ==
                                              provider.news[index].id) {
                                            isfound = true;
                                            return;
                                          }
                                        });
                                        if (isfound) {
                                          dbProvider.deleteNews(
                                              provider.news[index].id!);
                                        } else {
                                          dbProvider.insertFavoriteNews(
                                              provider.news[index]);
                                        }
                                      }
                                    },
                                    child: Provider.of<UiProvider>(context)
                                            .checkFav(provider.news[index])
                                        ? Image.asset(
                                            'assets/icons/lovered.png',
                                            width: 32.w,
                                            height: 32.h,
                                          )
                                        : Image.asset(
                                            'assets/icons/lovegrey.png',
                                            width: 32.w,
                                            height: 32.h,
                                          )),
                                InkWell(
                                    onTap: () async {
                                      await Share.share(
                                          '${provider.news[index].title ?? 'no Title'}\n${provider.news[index].url ?? 'no Link'}');
                                    },
                                    child: Image.asset(
                                      'assets/icons/share.png',
                                      width: 28.w,
                                      height: 28.h,
                                    )),
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
                      color: Colors.grey.shade400,
                      indent: 0,
                      endIndent: 0,
                      thickness: 12,
                    ),
                  ],
                );
              });
    });
  }
}
// DbHelper.dbHelper.insertFavoriteNews(
//   FavoriteModel(
//     title: provider.news[index].title.toString(),
//     url: provider.news[index].url.toString(),
//     image: provider.news[index].urlToImage.toString(),
//     publishedAt: provider.news[index].publishedAt.toString()
//   )
// );