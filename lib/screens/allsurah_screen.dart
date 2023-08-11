import 'package:flutter/material.dart';
import 'package:quran_app/utils/export_utils.dart';

import '../repositories/export_repo.dart';
import 'export_screens.dart';

class AllSurahScreen extends StatelessWidget {
  const AllSurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: QuranSurah().getAllSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 8.h,
                  backgroundColor: AppColors.scafoldBackgroundColor,
                  actions: [
                    IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/bookmarks'),
                        icon: const Icon(Icons.bookmark)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/searchSurah');
                        },
                        icon: const Icon(Icons.search)),
                  ],
                ),
                SliverPersistentHeader(
                    pinned: true, delegate: SliverHeaderAllSurahWidget()),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
                  child: Text(
                    "Semua Surah",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: snapshot.data!.length,
                  (context, index) {
                    return ListTile(
                      minVerticalPadding: 15.h,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SurahDetailScreen(
                                      index:
                                          snapshot.data![index].nomor!.toInt(),
                                    )));
                      },
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_right, size: 30.0)),
                      title: Text("${snapshot.data![index].namaLatin}"),
                      subtitle: Text("${snapshot.data![index].arti}"),
                      leading: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0.h, horizontal: 17.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.h),
                            color: AppColors.appbarBackgroundColor),
                        child: Text("${snapshot.data![index].nomor}"),
                      ),
                    );
                  },
                ))
              ],
            ),
          );
        } else {
          return const Center(child: Text("Theres Something Wrong"));
        }
      },
    ));
  }
}

class SliverHeaderAllSurahWidget extends SliverPersistentHeaderDelegate {
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
          Icon(LineIcons.quran, color: Colors.green, size: 30.0.h),
          SizedBox(width: 10.0.w),
          Text(
            "Al-Qur'an",
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
