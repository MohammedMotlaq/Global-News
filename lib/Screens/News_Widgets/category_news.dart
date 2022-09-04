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

class CategoryNews extends StatelessWidget {
  String nameCat;
  CategoryNews({Key? key, required this.nameCat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(239, 238, 238, 1.0),
        title: Text(
          nameCat,
          style: const TextStyle(
              color: Color.fromRGBO(0, 31, 194, 1.0), fontSize: 25),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
        iconTheme: const IconThemeData(color: Color.fromRGBO(0, 31, 194, 1.0)),
      ),
      body: Consumer2<NewsProvider, DbProvider>(
          builder: (context, provider, dbProvider, x) {
        return provider.discoverNews.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : ListView.builder(
                itemCount: provider.discoverNews.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          var url =
                              Uri.parse(provider.discoverNews[index].url!);
                          try {
                            await canLaunchUrl(url)
                                ? await launchUrl(url)
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
                                      imageUrl: provider
                                              .discoverNews[index].urlToImage ??
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
                                    provider.discoverNews[index].title ??
                                        'no title',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Text(
                                        provider.discoverNews[index].source!
                                                .name ??
                                            'Unknown',
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Container(
                                      width: 80.w,
                                      margin: EdgeInsets.only(right: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (provider.discoverNews[index]
                                                        .id ==
                                                    null)
                                                  dbProvider.insertFavoriteNews(
                                                      provider
                                                          .discoverNews[index]);
                                                else {
                                                  bool isfound = false;
                                                  dbProvider.favoritesNews
                                                      .forEach((element) {
                                                    if (element.id ==
                                                        provider
                                                            .discoverNews[index]
                                                            .id) {
                                                      isfound = true;
                                                      return;
                                                    }
                                                  });
                                                  if (isfound) {
                                                    dbProvider.deleteNews(
                                                        provider
                                                            .discoverNews[index]
                                                            .id!);
                                                  } else {
                                                    dbProvider.insertFavoriteNews(
                                                        provider.discoverNews[
                                                            index]);
                                                  }
                                                }
                                              },
                                              child: Provider.of<UiProvider>(
                                                          context)
                                                      .checkFav(provider
                                                          .discoverNews[index])
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
                                                    '${provider.discoverNews[index].title ?? 'no Title'}\n${provider.discoverNews[index].url ?? 'no Link'}');
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
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        indent: 0,
                        endIndent: 0,
                        thickness: 16,
                      ),
                    ],
                  );
                });
      }),
    );
  }
}
