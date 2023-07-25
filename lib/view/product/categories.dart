import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loris_bussiness/view/product/search.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cons/general.dart';
import '../../controller/productController.dart';
import '../../controller/startController.dart';
import '../../model/general/menuData.dart';
import '/theme/appColors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget {
  final Function? callBack;

  Categories({
    Key? key,
    this.callBack,
  }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int initialMenuId = 56;
  final _startController = StartController.to;
  final _productController = ProductController.to;

  List<MenuData> _menuList = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() async {
    var menugroups =
        _startController.getSettings('mobile_app', 'mobile_start_menus');
    var listmenus = menugroups.split('|');
    if (listmenus.length == 1) {
      var datas = _startController.startData.value['mobile_menu'];
      if (datas.length > 0) {
        datas.forEach((k, v) {
          if (k == listmenus[0].toString()) {
            setState(() {
              Iterable listT = v;
              _menuList =
                  listT.map((model) => MenuData.fromJson(model)).toList();
            });
          }
        });
      }
    }
  }

  void callbackCartList() async {
    _productController.setIsListLoading(true);
    Future.delayed(const Duration(milliseconds: 100), () {
      _productController.setIsListLoading(false);
    });

    widget.callBack!;
  }

  AnimationController? animController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kategoriler'),
          leading: IconButton(
              onPressed: () {
                Get.to(() => ProductSearch());
              },
              icon: Icon(Icons.search)),
        ),
        body: Center(
            child: _menuList.length > 0 ? _haveData() : Text('Hazirlanıyor')));
  }

  _haveData() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: AppColors.light,
                border: Border(
                  right: BorderSide(width: 1.0, color: AppColors.grey),
                )),
            child: SingleChildScrollView(
              child: Column(
                  children: _menuList
                      .map((item) => customMenuItem(menu: item))
                      .toList()),
            ),
          ),
        ),
        Expanded(
            flex: 10,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.white,
              child: _customMenuITemDetail(initialMenuId),
            ))
      ],
    );
  }

  _customMenuITemDetail(id) {
    List itemList = [];
    List<Container> itemContainer = [];
    bool multiChild = false;
    String selectedMenuTitle;
    _menuList.forEach((element) {
      if (element.id == initialMenuId) {
        selectedMenuTitle = element.title.toString();

        element.child!.forEach((i) {
          if (i.child!.length > 0) {
            multiChild = true;
            itemContainer.add(Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(i.title.toString(),
                  style: AppColors.darkT(bold: true, size: 15)),
              decoration: AppColors.boxDecorationBorderBottom,
            ));
            itemContainer.add(Container(
              child: StaggeredGridView.count(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 3, // I only need two card horizontally
                padding: const EdgeInsets.all(10),
                children: i.child!.map((item) {
                  MenuData menu = item;
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, item.link ?? '/productList',
                            arguments: RouteSettings(name: item.title));
                      },
                      child: Container(
                          child: Column(
                        children: [
                          Container(
                              height: 250,
                              decoration: menu.image != null
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              GeneralCons.imageUrl +
                                                  menu.image! +
                                                  '?s=small'),
                                          fit: BoxFit.cover),
                                    )
                                  : AppColors.boxDecorationBorderBottomGrey),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            height: 60,
                            child: Center(
                                child: Text(menu.title!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.2,
                                        fontSize: 14,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w700))),
                          )
                        ],
                      )));
                }).toList(),

                //Here is the place that we are getting flexible/ dynamic card for various images
                staggeredTiles: i.child!
                    .map<StaggeredTile>((_) => StaggeredTile.fit(1))
                    .toList(),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0, // add some space
              ),
            ));
            i.child!.forEach((inelement) {});
          } else {
            itemList.add(i);
            multiChild = false;
          }
        });
      }
    });
    if (multiChild) {
      return FadeInRight(
          controller: (controller) => animController = controller,
          child: SingleChildScrollView(
            child: Column(
              children: itemContainer,
            ),
          ));
    } else {
      return FadeInRight(
          controller: (controller) => animController = controller,
          child: StaggeredGridView.count(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            crossAxisCount: 3, // I only need two card horizontally
            padding: const EdgeInsets.all(10),
            children: itemList.map((item) {
              MenuData menu = item;

              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context,
                        (item.link != null) ? item.link : '/productList',
                        arguments: RouteSettings(name: item.title));
                  },
                  child: Container(
                      child: Column(
                    children: [
                      Container(
                          height: 190,
                          decoration: menu.image != null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(GeneralCons.imageUrl +
                                          menu.image! +
                                          '?s=small'),
                                      fit: BoxFit.cover),
                                )
                              : AppColors.boxDecorationBorderBottomGrey),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        height: 60,
                        child: Center(
                            child: Text(menu.title!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700))),
                      )
                    ],
                  )));
            }).toList(),

            //Here is the place that we are getting flexible/ dynamic card for various images
            staggeredTiles: itemList
                .map<StaggeredTile>((_) => StaggeredTile.fit(1))
                .toList(),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0, // add some space
          ));
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget customMenuItem({menu}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (menu.child!.length > 0) {
            initialMenuId = menu.id;
            //0animController.reset();
          } else {
            if (menu.linkType == 1 ||
                menu.linkType == 3 ||
                menu.linkType == 20) {
              Navigator.pushNamed(
                  context, (menu.link != "") ? menu.link : '/productList',
                  arguments: RouteSettings(name: menu.link));
            }
            if (menu.linkType == 4) {
              _launchURL(menu.link);
            }
          }
        });
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: initialMenuId == menu.id ? AppColors.white : AppColors.light,
            border: Border(
              bottom: BorderSide(width: 1.0, color: AppColors.grey),
            )),
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        menu.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: initialMenuId == menu.id
                                ? AppColors.dark
                                : Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _noData() {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Kategorilerim',
                style: TextStyle(
                    color: AppColors.dark,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            Text('Kategoriler bulunamadı.'),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              onPressed: () {},
              color: AppColors.primary,
              child: Text(
                'Alışverişe Devam Et',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ));
  }
}
