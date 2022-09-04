import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class PopularPage extends StatelessWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
          builder: (context,provider,x) {
            return
              provider.allNews.isEmpty?
              const Center(child: CircularProgressIndicator(color: Colors.grey,),):
              ListView.builder(
                  itemCount: provider.allNews.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        InkWell(
                          onTap: ()async{
                            var url = Uri.parse(provider.allNews[index].url!);
                            try{
                              await canLaunchUrl(url)? await launchUrl(url): throw 'Could not open URL';
                            }catch(e){
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
                                        imageUrl: provider.allNews[index].urlToImage??"https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                        errorWidget:  (context, url, error) => const Icon(Icons.error),
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
                                      provider.allNews[index].title??'no title',
                                      style:const  TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Text(
                                          provider.allNews[index].source!.name??'Unknown',
                                          overflow: TextOverflow.clip,
                                          style:const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.favorite,color: Colors.grey,size: 25,),
                                            Icon(Icons.bookmark_add_outlined,color: Colors.grey,size: 25,),
                                            Icon(Icons.share_outlined,color: Colors.grey,size: 25,)
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
                  }
              );
          }
      );

  }
}
