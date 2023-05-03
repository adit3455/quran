import 'package:flutter/material.dart';
import 'package:quran_app/utils/export_utils.dart';

import '../blocs/export_blocs.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/setting'),
              icon: const Icon(Icons.settings)),
          SizedBox(width: 10.0.w),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  width: 300.w,
                  height: 70.h,
                  margin: EdgeInsets.all(10.0.h),
                  padding: EdgeInsets.all(10.0.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bookmarks, color: Colors.green),
                      SizedBox(width: 15.0.w),
                      Text("Bookmarks",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontWeight: FontWeight.w500))
                    ],
                  )),
            ),
            SizedBox(height: 10.0.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Semua hasil bookmark kamu",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            BlocBuilder<BookmarksBloc, BookmarksState>(
              builder: (context, state) {
                if (state is BookmarksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookmarksLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.ayat.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0.h)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0.w, horizontal: 10.h),
                                    child: Text("${index + 1}")),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(3.0.h),
                                  width: 285.w,
                                  child: Text("${state.ayat[index].ar}",
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<BookmarksBloc>().add(
                                          RemoveBookmarks(
                                              ayat: state.ayat[index],
                                              index: index));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              padding: EdgeInsets.all(5.h),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 5.w),
                                              elevation: 2,
                                              showCloseIcon: true,
                                              backgroundColor:
                                                  AppColors.cardBackgroundColor,
                                              content: Text(
                                                  "Menghapus Bookmark",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium)));
                                    },
                                    icon: const Icon(
                                      Icons.bookmark,
                                      color: AppColors.cardBackgroundColor,
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(10.0),
                                    width: 290.w,
                                    child: Text("${state.ayat[index].tr}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.all(3.0),
                                width: 290.w,
                                child: Text("${state.ayat[index].idn}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium)),
                            SizedBox(height: 5.0.h),
                            const Divider(
                                thickness: 1,
                                color: AppColors.cardBackgroundColor)
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
