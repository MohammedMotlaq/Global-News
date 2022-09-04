import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Providers/news_provider.dart';


class CategoryNews extends StatelessWidget {
  String nameCat;
  CategoryNews({Key? key,required this.nameCat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:const Color.fromRGBO(239, 238, 238, 1.0),
        title: Text(nameCat,style:const TextStyle(color: Color.fromRGBO(0, 31, 194, 1.0),fontSize: 25),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded,size: 30,)
        ),
        iconTheme:const IconThemeData(
          color: Color.fromRGBO(0, 31, 194, 1.0)
        ),
      ),
      body: Consumer<NewsProvider>(
          builder: (context,provider,x) {
            return
              provider.discoverNews.isEmpty?
              const Center(child: CircularProgressIndicator(color: Colors.grey,),):
              ListView.builder(
                  itemCount: provider.discoverNews.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        InkWell(
                          onTap: ()async{
                            var url = Uri.parse(provider.discoverNews[index].url!);
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
                                        imageUrl: provider.discoverNews[index].urlToImage??"https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",
                                        errorWidget:  (context, url, error) => Image.network("https://play-lh.googleusercontent.com/blO52aLoIwSmO6mYe7cL2ZxV6zhPDC7--AdpcSkVrpPaeZJouPrbaD6Iz51VNdmu9Vc",fit: BoxFit.fill,),
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
                                      provider.discoverNews[index].title??'no title',
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
                                          provider.discoverNews[index].source!.name??'Unknown',
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
      ),
    );
  }
}
