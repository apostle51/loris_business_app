import '/components/skeleton/generalSK.dart';
import '/theme/appColors.dart';
import 'package:flutter/material.dart';

class ProductItemSK extends StatelessWidget {
  const ProductItemSK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.3),
                  )),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: 25,
                        // color: Colors.red.withOpacity(0.3),
                        child: SkeletonContainer.square(
                          width: 90,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 270,
            left: 10,
            width: 28,
            height: 28,
            child: SkeletonContainer.square(width: 100, height: 20))
      ],
    );
  }
}
