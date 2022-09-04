import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'category_news.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List cats = [
      {
        'name': 'Crypto',
        'image': 'assets/images/coins.jpg',
        'title': 'Bitcoin'
      },
      {'name': 'Sports', 'image': 'assets/images/sports.jpg', 'title': 'sport'},
      {
        'name': 'Business',
        'image': 'assets/images/business.png',
        'title': 'Business man'
      },
      {
        'name': 'Entertainment',
        'image': 'assets/images/intertainment.jpg',
        'title': 'Entertainment'
      },
      {
        'name': 'Science',
        'image': 'assets/images/sience.jpg',
        'title': 'Science'
      },
      {
        'name': 'Technology',
        'image': 'assets/images/technology.jpg',
        'title': 'pc phones'
      },
      {
        "name": 'Health',
        'image': 'assets/images/health.jpg',
        'title': 'virus health Sick'
      },
      {
        'name': 'Policy',
        'image': 'assets/images/policy.jpg',
        'title': 'American politics '
      },
    ];
    return Consumer<NewsProvider>(builder: (context, provider, x) {
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(cats.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                provider.selectDisNews(cats[index]['title']);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return CategoryNews(nameCat: cats[index]['name']);
                }));
              },
              child: Container(
                width: 180.w,
                height: 180.h,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          cats[index]['image'],
                          fit: BoxFit.cover,
                          width: 180.w,
                          height: 180.h,
                        )),
                    Text(
                      cats[index]['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
