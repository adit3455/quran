import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/repositories/base_repo.dart';
import 'package:quran_app/screens/allfeed_screen.dart';
import 'package:quran_app/utils/export_utils.dart';

import '../widgets/export_widgets.dart';
import 'export_screens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                pinned: true,
                expandedHeight: 0.h,
                toolbarHeight: 0.h,
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 225.h,
                  width: double.infinity,
                  color: AppColors.appbarBackgroundColor,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Assalamu'alaikum, Sahabat",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: 22.0,
                                                color: Colors.white),
                                      ),
                                      Text(
                                        "Medan, 04 Februari 2023",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.settings)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18.w,
                        top: 100.h,
                        child: Container(
                          width: 325.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.cardBackgroundColor),
                          child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Maghrib 18:30 WIB",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 20),
                                      ),
                                      Text(
                                        "2:30:10 Menjelang Adzan",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  maxRadius: 30.h,
                                  backgroundImage: const NetworkImage(
                                      "https://riaupos.co/thumb/2867-13950133625_d490cfefe3_z.jpg"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 205.h,
                        child: Container(
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.0)),
                              color: AppColors.scafoldBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverHeaderHomePage(),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Feed Untukmu"),
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllFeedScreen())),
                              child: const Text("Lihat Semua"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 7,
                  (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedDetailScreen(
                                      articles: snapshot.data!.articles![index],
                                    )));
                      },
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 5.0.h),
                        child: Text(
                          "${snapshot.data!.articles![index].title}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      subtitle: Text(
                          "${snapshot.data!.articles![index].publishedAt}",
                          style: Theme.of(context).textTheme.bodyMedium),
                      trailing: Image.network(
                          fit: BoxFit.cover,
                          width: 120.w,
                          "${snapshot.data!.articles![index].urlToImage}"),
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return const Text("Theres Something Wrong");
        }
      },
    ));
  }
}
