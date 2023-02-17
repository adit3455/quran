import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/repositories/base_repo.dart';
import 'package:quran_app/screens/export_screens.dart';
import 'package:quran_app/utils/export_utils.dart';

class AllFeedScreen extends StatelessWidget {
  const AllFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<FeedModel>(
      future: QuranSurah().getFeed(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 8.h,
                backgroundColor: AppColors.scafoldBackgroundColor,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.bookmark)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              SliverPersistentHeader(
                  pinned: true, delegate: SliverHeaderAllDoaWidget()),
              SliverToBoxAdapter(
                  child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All Feeds",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500)),
                    Text("Menampilkan ${snapshot.data!.articles!.length} Feed",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              )),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: snapshot.data!.articles!.length,
                (context, index) {
                  return ListTile(
                    minVerticalPadding: 15.h,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedDetailScreen(
                                  articles: snapshot.data!.articles![index])));
                    },
                    title: Text("${snapshot.data!.articles![index].title}"),
                    subtitle:
                        Text("${snapshot.data!.articles![index].publishedAt}"),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        "${snapshot.data!.articles![index].urlToImage}",
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 150.h,
                      ),
                    ),
                    leading: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 17.0.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0.h),
                          color: AppColors.appbarBackgroundColor),
                      child: Text("${index + 1}"),
                    ),
                  );
                },
              ))
            ],
          );
        } else {
          return const Text("Theres Something Wrong");
        }
      },
    ));
  }
}

class SliverHeaderAllDoaWidget extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.all(20.0),
      padding: EdgeInsets.all(10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LineIcons.newspaper, color: Colors.green, size: 30.0.h),
          SizedBox(width: 10.0.w),
          Text(
            "All Feeds",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100.h;

  @override
  double get minExtent => 90.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
