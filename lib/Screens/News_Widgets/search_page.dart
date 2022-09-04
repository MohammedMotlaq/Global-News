import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

import '../../Providers/db_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    TextEditingController controller = TextEditingController();

    return Consumer2<NewsProvider, DbProvider>(
        builder: (context, provider, dbProvider, x) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formState,
              child: Container(
                //color: Colors.red,
                width: 390.w,
                height: 40.h,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required Value';
                    } else if (value.length < 2) {
                      return "your content must be more than 2 characters";
                    }
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    suffixIcon: InkWell(
                        onTap: () {
                          if (formState.currentState!.validate()) {
                            provider.searchTitleNews(controller.text);
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          size: 30,
                          color: Color.fromRGBO(0, 31, 194, 1.0),
                        )),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                    ),
                  ),
                  cursorColor: Colors.black,
                  cursorHeight: 22,
                  cursorRadius: const Radius.circular(10),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(
              width: 393.w,
              height: 646.h,
              child: Consumer<NewsProvider>(builder: (context, provider, x) {
                return provider.searchNews.isEmpty
                    ? Lottie.asset('assets/animations/search.json')
                    : ListView.builder(
                        itemCount: provider.searchNews.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  var url = Uri.parse(
                                      provider.searchNews[index].url!);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: CachedNetworkImage(
                                              width: 380.w,
                                              height: 200.h,
                                              fit: BoxFit.fill,
                                              imageUrl: provider
                                                      .searchNews[index]
                                                      .urlToImage ??
                                                  "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.network(
                                                        'https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc',
                                                        fit: BoxFit.fill,
                                                      ),
                                              placeholder: (context, url) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              }),
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          child: Text(
                                            provider.searchNews[index].title ??
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
                                                provider.searchNews[index]
                                                        .source!.name ??
                                                    'Unknown',
                                                overflow: TextOverflow.clip,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 110.w,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        if (provider.news[index]
                                                                .id ==
                                                            null)
                                                          dbProvider
                                                              .insertFavoriteNews(
                                                                  provider.news[
                                                                      index]);
                                                        else {
                                                          bool isfound = false;
                                                          dbProvider
                                                              .favoritesNews
                                                              .forEach(
                                                                  (element) {
                                                            if (element.id ==
                                                                provider
                                                                    .news[index]
                                                                    .id) {
                                                              isfound = true;
                                                              return;
                                                            }
                                                          });
                                                          if (isfound) {
                                                            dbProvider.deleteNews(
                                                                provider
                                                                    .news[index]
                                                                    .id!);
                                                          } else {
                                                            dbProvider
                                                                .insertFavoriteNews(
                                                                    provider.news[
                                                                        index]);
                                                          }
                                                        }
                                                      },
                                                      child: Provider.of<
                                                                      UiProvider>(
                                                                  context)
                                                              .checkFav(provider
                                                                  .news[index])
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
                                                  Icon(
                                                    Icons.bookmark_add_outlined,
                                                    color: Colors.grey,
                                                    size: 25,
                                                  ),
                                                  Icon(
                                                    Icons.share_outlined,
                                                    color: Colors.grey,
                                                    size: 25,
                                                  )
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
            ),
          ],
        ),
      );
    });
  }
}
