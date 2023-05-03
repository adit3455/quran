import 'package:flutter/material.dart';
import 'package:quran_app/repositories/export_repo.dart';
import 'package:quran_app/screens/export_screens.dart';
import 'package:quran_app/utils/export_utils.dart';

import '../blocs/export_blocs.dart';

class SearchQuranScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navigationWidgetList = [
      {
        "title": "AL-Qur'an",
        "ontap": () {
          Navigator.pushNamed(context, "/allsurah");
        },
        "icon": LineIcons.quran
      },
      {
        "title": "Do'a",
        "ontap": () {
          Navigator.pushNamed(context, "/alldoa");
        },
        "icon": LineIcons.prayingHands
      },
      {
        "title": "Waktu Adzan",
        "ontap": () {
          Navigator.pushNamed(context, "/waktuAdzan");
        },
        "icon": LineIcons.calendarTimes
      },
      {
        "title": "Dziarah",
        "ontap": () {
          Navigator.pushNamed(context, "/dziarah");
        },
        "icon": LineIcons.pray
      }
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/setting'),
              icon: const Icon(Icons.settings)),
          SizedBox(
            width: 10.0.w,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SearchSurahBloc(QuranSurah()),
        child: BlocConsumer<SearchSurahBloc, SearchSurahState>(
          listener: (context, state) {
            if (state is SearchError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is SearhSurahLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchNotFoundState) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  TextFormField(
                    controller: _searchController,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search your Surah here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            if (_searchController.text.isNotEmpty) {
                              context
                                  .read<SearchSurahBloc>()
                                  .add(SurahSearched(_searchController.text));
                            }
                          },
                          child: const Text("Seach"))),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 15.0.h),
                    child: Text(
                      "Tidak menemukan surah apapun",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ]),
              );
            } else if (state is SearchSurahInitial) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            width: 250.w,
                            height: 70.h,
                            margin: EdgeInsets.all(10.0.h),
                            padding: EdgeInsets.all(10.0.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.search, color: Colors.green),
                                SizedBox(width: 15.0.w),
                                Text("Search Surah",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontWeight: FontWeight.w500))
                              ],
                            )),
                      ),
                      SizedBox(height: 10.0.h),
                      TextFormField(
                        controller: _searchController,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search your Surah here",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  context.read<SearchSurahBloc>().add(
                                      SurahSearched(_searchController.text));
                                }
                              },
                              child: const Text("Seach"))),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 15.0.h),
                        child: Text(
                          "Navigate to other Screen?",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 10,
                          spacing: 10,
                          children: List.generate(
                              navigationWidgetList.length,
                              (index) => _navigationWidgetSearch(
                                  context,
                                  navigationWidgetList[index]['ontap'],
                                  navigationWidgetList[index]['title'],
                                  navigationWidgetList[index]['icon']))),
                      SizedBox(height: 13.0.h),
                      Center(
                          child: _navigationWidgetSearch(
                              context,
                              () => Navigator.pushNamed(context, '/yasin'),
                              'Yasin',
                              Icons.book,
                              isSize: true)),
                    ],
                  ),
                ),
              );
            } else if (state is SearhStateLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0.h),
                      TextFormField(
                        controller: _searchController,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search your Surah here",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  context.read<SearchSurahBloc>().add(
                                      SurahSearched(_searchController.text));
                                }
                              },
                              child: const Text("Seach"))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Menampilkan Hasil pencarianmu",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                "${state.surahs.length} item",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ]),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.surahs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            minVerticalPadding: 15.h,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurahDetailScreen(
                                      index: state.surahs[index].nomor!.toInt(),
                                    ),
                                  ));
                            },
                            trailing: IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.arrow_right, size: 30.0)),
                            title: Text("${state.surahs[index].namaLatin}"),
                            subtitle: Text("${state.surahs[index].arti}"),
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
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text("Theres Something wrong"));
          },
        ),
      ),
    );
  }

  Material _navigationWidgetSearch(
      BuildContext context, void Function()? onTap, String title, IconData icon,
      {bool isSize = false}) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: AppColors.appbarBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Container(
          height: 80.h,
          width: isSize == false ? 160.w : 200.w,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40.h,
              ),
              SizedBox(width: 10.0.w),
              SizedBox(
                width: 100.w,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15.0.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
