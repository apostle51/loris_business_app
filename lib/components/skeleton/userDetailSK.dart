import 'package:flutter/material.dart';
import '/theme/appColors.dart';

import 'generalSK.dart';

class UserDetailSkeleton extends StatelessWidget {
  const UserDetailSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.grey),
          padding: EdgeInsets.only(
              left: 15, right: 15, bottom: 30, top: statusBarHeight),
          alignment: Alignment.center,
          child: Column(
            children: [
              Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              SkeletonContainer.square(
                width: 200,
                height: 25,
              ),
              SizedBox(
                height: 10,
              ),
              SkeletonContainer.square(
                width: 300,
                height: 25,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                decoration: AppColors.boxDecorationBorderBottom,
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                  title: SkeletonContainer.square(
                    width: 250,
                    height: 20,
                  ),
                ),
              ),
              Container(
                decoration: AppColors.boxDecorationBorderBottom,
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                  title: SkeletonContainer.square(
                    width: 250,
                    height: 20,
                  ),
                ),
              ),
              Container(
                decoration: AppColors.boxDecorationBorderBottom,
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                  title: SkeletonContainer.square(
                    width: 250,
                    height: 20,
                  ),
                ),
              ),
              Container(
                decoration: AppColors.boxDecorationBorderBottom,
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                  title: SkeletonContainer.square(
                    width: 250,
                    height: 20,
                  ),
                ),
              ),
              Container(
                decoration: AppColors.boxDecorationBorderBottom,
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                  title: SkeletonContainer.square(
                    width: 250,
                    height: 20,
                  ),
                ),
              ),
              Container(
                decoration: AppColors.boxDecorationBorderBottom,
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                  ),
                  title: SkeletonContainer.square(
                    width: 250,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
