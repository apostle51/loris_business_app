import 'package:flutter/material.dart';
import '/theme/appColors.dart';
import 'generalSK.dart';

class ShowCaseSK extends StatelessWidget {
  const ShowCaseSK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: SkeletonContainer.square(
              width: 180,
              height: 12,
            ),
          ),
          Container(
            height: 340,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Card(child: _productItem()));
                }),
          )
        ],
      ),
    );
  }

  _productItem() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 250,
            color: AppColors.grey,
            child: Stack(
              children: [
                Positioned(
                  width: 30,
                  height: 30,
                  top: 10,
                  right: 10,
                  child: SkeletonContainer.circular(
                    height: 30,
                    width: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 70,
            width: double.infinity,
            color: AppColors.white,
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonContainer.square(
                  width: 80,
                  height: 12,
                ),
                SizedBox(
                  height: 10,
                ),
                SkeletonContainer.square(
                  width: 140,
                  height: 12,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonContainer.square(
                      width: 60,
                      height: 12,
                    ),
                    SkeletonContainer.square(
                      width: 60,
                      height: 12,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
