import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/theme/appColors.dart';

import '/components/skeleton/showCaseSK.dart';

import 'generalSK.dart';

class IndexSK extends StatelessWidget {
  const IndexSK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        leading: IconButton(
            icon: Icon(
              Icons.search,
              size: 22,
              color: AppColors.white,
            ),
            onPressed: () {}),
        actions: [
          IconButton(
              icon: Icon(
                Icons.info,
                size: 22,
                color: AppColors.white,
              ),
              onPressed: () {})
        ],
        centerTitle: true,
        title: Center(
          child: SvgPicture.asset('assets/logo/logoebijuteri.svg', width: 120),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10),
              height: 90,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          SkeletonContainer.circular(
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SkeletonContainer.square(
                            width: 60,
                            height: 12,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 200,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: SkeletonContainer.square(
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 30,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SkeletonContainer.square(
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ),
            ShowCaseSK()
          ],
        ),
      ),
    );
  }
}
