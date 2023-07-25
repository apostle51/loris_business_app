import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../components/home/homeBanner.dart';
import '../components/home/homeSlider.dart';
import '../cons/general.dart';
import '../controller/startController.dart';
import '../theme/AppColors.dart';
import 'general/contact.dart';
import 'product/search.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _startController = StartController.to;
  bool indexLoader = true;
  var sliders;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() {
    setState(() {
      indexLoader = true;
    });

    setState(() {
      indexLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          showAlertDialog(context);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            actions: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/logo/loriso.svg",
                    width: 16,
                  ),
                  onPressed: () => Get.to(() => Contact())),
            ],
            leading: IconButton(
                onPressed: () {
                  Get.to(() => ProductSearch());
                },
                icon: Icon(
                  Icons.search,
                  color: AppColors.dark,
                )),
            title: SvgPicture.asset("assets/images/logo/logo.svg",
                width: 80, semanticsLabel: GeneralCons.appName),
          ),
          body: indexLoader
              ? const SizedBox()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      if (_startController.sliderList.value.length > 0)
                        MainSlider(
                          data: _startController.sliderList.value,
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ProductSearch());
                        },
                        child: Container(
                          color: AppColors.black,
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                            decoration: AppColors.searchContainer,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.search,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    ' Kokunu Aramaya Başla ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (_startController.homeBanners.value.length > 0)
                        HomeBanners(
                          data: _startController.homeBanners.value,
                          visualType: 2,
                        ),
                    ],
                  ),
                ),
        ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = MaterialButton(
    color: Colors.white,
    child: Text(
      "Kapat",
      style: TextStyle(color: AppColors.dark),
    ),
    onPressed: () => SystemNavigator.pop(),
  );
  Widget continueButton = MaterialButton(
    color: AppColors.dark,
    child: Text(
      "Geri Dön",
      style: TextStyle(color: AppColors.white),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Uygulama Kapatılacak",
      style: TextStyle(fontWeight: FontWeight.bold, height: 1),
    ),
    content: const Text("Uygulamayı kapatmak istiyor musunuz ?",
        style: TextStyle(height: 1)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
