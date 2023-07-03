import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:news_app/Providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';
import '../../Providers/db_provider.dart';
import '../WebView/web_view_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    TextEditingController controller = TextEditingController();

    return Consumer3<NewsProvider, DbProvider,UiProvider>(
        builder: (context, provider, dbProvider,uiProvider, x) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              child: Form(
                key: formState,
                child: Container(
                  width: 390.w,
                  height: 40.h,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (String textValue){
                      provider.searchTitleNews(textValue);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none
                      ),
                      fillColor: uiProvider.searchBox,
                      filled: true,
                      suffixIcon: InkWell(
                        onTap: () {
                          if (formState.currentState!.validate()) {
                            provider.searchTitleNews(controller.text);
                          }
                        },
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: uiProvider.searchIcon,
                        )
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1.0),
                      ),
                    ),
                    cursorColor: uiProvider.textSearch,
                    cursorHeight: 22,
                    cursorRadius: const Radius.circular(10),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    maxLines: 1,
                    style: TextStyle(
                      color: uiProvider.textSearch,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 393.w,
              height: 650.h,
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
                              // var url = Uri.parse(provider.searchNews[index].url!);
                              // try {
                              //   await canLaunchUrl(url) ? await launchUrl(url) : throw 'Could not open URL';
                              // } catch (e) {
                              //   log(e.toString());
                              // }
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  WebViewPage(newsURL: provider.searchNews[index].url!,)));

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
                                        imageUrl: provider.searchNews[index].urlToImage ?? "https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                        errorWidget: (context, url, error) =>
                                        Image.network(
                                          'https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc',
                                          fit: BoxFit.fill,
                                        ),
                                        placeholder: (context, url) {
                                          return const Center(child: CircularProgressIndicator(color: Colors.grey,),);
                                        }
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      margin: EdgeInsets.symmetric(vertical: 8.h),
                                      child: Text(
                                        provider.searchNews[index].title ?? 'no title',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: uiProvider.textColor
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: Text(
                                            "Published At: ${provider.searchNews[index].publishedAt?.substring(0, 10) ?? 'UnKnown'}",
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
                                                  if (provider.searchNews[index].id == null) {
                                                    dbProvider.insertFavoriteNews(provider.searchNews[index]);
                                                  } else {
                                                    bool isFound = false;
                                                    dbProvider.favoritesNews.forEach((element) {
                                                      if (element.id == provider.searchNews[index].id) {
                                                        isFound = true;
                                                        return;
                                                      }
                                                    });
                                                    if (isFound) {
                                                      dbProvider.deleteNews(
                                                          provider.searchNews[index].id!);
                                                    } else {
                                                      dbProvider.insertFavoriteNews(provider.searchNews[index]);
                                                    }
                                                  }
                                                },
                                                child: Provider.of<UiProvider>(context).checkFav(provider.searchNews[index])
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
                                                  await Share.share(provider.searchNews[index].url ?? 'no Link');
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
                  );
              }),
            ),
          ],
        ),
      );
    });
  }
}
