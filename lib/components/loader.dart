import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../cons/general.dart';
import '/theme/AppColors.dart';

class FirstLoader extends StatelessWidget {
  Color gradientEnd = AppColors.light; //Change start gradient color here
  Color gradientStart = AppColors.lighter; //Change end gradient color here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splashscreenloader.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            width: Get.width,
            child: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.dark)),
            ),
          )
        ],
      ),
    ));
  }
}

class PageLoaderScf extends StatelessWidget {
  Color gradientEnd = AppColors.light; //Change start gradient color here
  Color gradientStart = AppColors.lighter; //Change end gradient color here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: PageLoader(),
      ),
    ));
  }
}

class PageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        new Opacity(
          opacity: 0.5,
          child: const ModalBarrier(dismissible: false, color: Colors.black12),
        ),
        new Center(
          child: Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 4,
              child: Container(
                width: 120,
                height: 100,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.dark)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Yükleniyor...',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

class LorisLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // new Opacity(
            //   opacity: 0.5,
            //   child:
            //       const ModalBarrier(dismissible: false, color: Colors.black12),
            // ),
            SvgPicture.asset("assets/images/logo/logo.svg",
                width: 300, semanticsLabel: GeneralCons.appName),
            SizedBox(
              height: 120,
            ),
            Container(
              width: 200,
              height: 130,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.dark)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Yükleniyor...',
                    style: TextStyle(fontSize: 15, letterSpacing: 2),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinearIndicatorLoader extends StatelessWidget {
  String? title;
  LinearIndicatorLoader({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        child: Column(
          children: <Widget>[
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.dark,
              ),
              //backgroundColor: AppTheme.lorisOrange,
            ),
            SizedBox(
              height: 20,
            ),
            Text(title ?? 'Yükleniyor , Lütfen Bekleyiniz...')
          ],
        ));
  }
}
