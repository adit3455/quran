import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class NotificationAlertsWidget {
  final String? title;
  final String? subTitle;
  final String? content;
  final String? underContent;

  NotificationAlertsWidget(
      {this.title, this.subTitle, this.content, this.underContent});

  void showNotificationAlertsDoaWidget(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(8.0.h),
                  decoration: BoxDecoration(
                      color: AppColors.scafoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          width: 1, color: AppColors.cardBackgroundColor)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        "$title",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 280.w,
                            child: Text(
                              "$subTitle",
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        "$content",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10.0),
                      Text("$underContent",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 20.0),
                      Center(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Back")),
                      )
                    ],
                  )));
        },
      );

  void showNotificationAlertsAdzanWidget(
      BuildContext context,
      String? imsyak,
      String? shubuh,
      String? dhuha,
      String? dzuhur,
      String? ashr,
      String? maghrib,
      String? isya) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(8.0.h),
                  decoration: BoxDecoration(
                      color: AppColors.scafoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          width: 1, color: AppColors.cardBackgroundColor)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        "$title",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                      const SizedBox(height: 20.0),
                      const SizedBox(height: 15.0),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$imsyak",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$shubuh",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$dhuha",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$dzuhur",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$ashr",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$maghrib",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "$isya",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                      const SizedBox(height: 20.0),
                      Center(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Back")),
                      )
                    ],
                  )));
        });
  }
}
