import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:loris_bussiness/view/product/smelltest.dart';

import '../controller/startController.dart';
import '../theme/AppColors.dart';
import '../utilities/getSvgIcons.dart';
import 'general/contact.dart';
import 'home.dart';
import 'product/categories.dart';

class Index extends StatefulWidget {
  Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  PageController pageController = PageController();
  final _startController = StartController.to;
  bool loader = true;
  int selectedBottomItem = 0;
  late String playStoreUrl;
  late String appStoreUrl;
  late int introBannerGroupID;

  void changeTab(index) {
    pageController.jumpToPage(index);
    setState(() {
      selectedBottomItem = index;
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() async {
    setState(() {
      loader = true;
    });
    selectedBottomItem = _startController.selectedTabIndex.value;

    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _index();
  }

  _index() {
    return Scaffold(
      bottomNavigationBar: customBottomNavigationBar(context),
      body: Container(
          child: PageView(
        key: Key('Index'),
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Home(),
          Categories(),
          SmellTest(
            showBack: false,
          )
        ],
      )
          //Home(),
          ),
    );
  }

  customBottomNavigationBar(context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(-4, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: customBottomNavigationBarItem("home", 'Anasayfa', 0),
          ),
          Expanded(
            child: customBottomNavigationBarItem("category", 'Ürünler', 1),
          ),
          Expanded(
            child: customBottomNavigationBarItem('heart', 'Koku Testi', 2),
          ),
        ],
      ),
    );
  }

  customBottomNavigationBarItem(String iconName, String text, int index,
      {int? badge}) {
    return GestureDetector(
      onTap: () {
        changeTab(index);
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            gradient: selectedBottomItem == index
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.white, AppColors.white])
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.white, AppColors.white]),
            border: Border()),
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BounceInDown(
                      from: 25,
                      child: Container(
                        height: 25,
                        margin: EdgeInsets.only(bottom: 4),
                        child: GetSVGIcon(
                          color: selectedBottomItem == index
                              ? AppColors.dark
                              : AppColors.grey,
                          icon: iconName,
                          size: 18,
                        ),
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: selectedBottomItem == index
                              ? AppColors.dark
                              : AppColors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0),
                    ),
                  ],
                ),
              ),
            ),
            badge != null && badge > 0
                ? Positioned(
                    top: 0,
                    right: 13,
                    child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: Text(
                              badge.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
