import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Models/favorite_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helpers/database_helper.dart';
import '../../Providers/db_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<DbProvider>(builder: (context, provider, x) {
        return provider.favoritesNews.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : ListView.builder(
                itemCount: provider.favoritesNews.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          var url =
                              Uri.parse(provider.favoritesNews[index].url!);
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
                                      imageUrl: provider.favoritesNews[index]
                                              .urlToImage ??
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
                                    provider.favoritesNews[index].title ??
                                        'no title',
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
                                "Published At: ${provider.favoritesNews[index].publishedAt?.substring(11, 16) ?? 'UnKnown'}",
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            SizedBox(
                              width: 110.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        provider.deleteNews(
                                            provider.favoritesNews[index].id!);
                                      },
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 25,
                                      )),
                                  Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await Share.share(
                                            '${provider.favoritesNews[index].title ?? 'no Title'}\n${provider.favoritesNews[index].url ?? 'no Link'}');
                                      },
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: Colors.grey,
                                        size: 25,
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
      }),
    );
  }
}
