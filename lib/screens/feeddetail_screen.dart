import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/utils/export_utils.dart';

class FeedDetailScreen extends StatelessWidget {
  final Articles articles;
  const FeedDetailScreen({required this.articles, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Feed Detail",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/setting'),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColors.appbarBackgroundColor),
                  ),
                  Positioned(
                    top: 1.h,
                    child: Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30.0)),
                          color: AppColors.scafoldBackgroundColor),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Text("${articles.title}",
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.h),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Published By ${articles.author}",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(height: 5.0.h),
                        Text("Published at ${articles.publishedAt}",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                    height: 200.h,
                    width: 340.w,
                    fit: BoxFit.cover,
                    "${articles.urlToImage}"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "${articles.content}",
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ));
  }
}
