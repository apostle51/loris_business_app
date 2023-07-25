import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loris_bussiness/view/product/search.dart';
import '../../components/grid.dart';
import '../../components/product/productItem.dart';
import '../../components/skeleton/productListSK.dart';
import '../../controller/productController.dart';
import '../../controller/startController.dart';
import '../../model/product/productCategory.dart';
import '../../utilities/publicFunction.dart';
import '/components/general/pageChangeAnimation.dart';
import '/theme/appColors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _startController = StartController.to;
final _productController = ProductController.to;

final keys = new GlobalKey<ProductListState>();

double offset = 0.0;
List resulList = [];

List<dynamic> favoritesAll = [];
ScrollController? controller;
ProductCategoryData productCategoryData = ProductCategoryData();
String? getCategoryLink;
int cartCount = 0;
bool hasSubCategory = false;
bool loader = false;
bool orjinalShow = false;

class ProductList extends StatefulWidget {
  final String? categoryLink;
  final String? searchQuery;
  final List? smellTestIds;

  var callback;
  ProductList(
      {Key? key,
      this.callback,
      this.smellTestIds,
      this.categoryLink,
      this.searchQuery})
      : super(key: key);

  double getOffsetMethod() {
    return offset;
  }

  void setOffsetMethod(double val) {
    offset = val;
  }

  @override
  ProductListState createState() {
    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {
  int getDataSize = 0;
  int page = 1;
  late int totalPage;
  late int currentPage;
  bool hasMore = true;
  bool shouldPop = true;
  bool buttonLoader = false;
  bool featureLoader = false;
  bool shoppingStatus = true;

  String? sortBy;
  String sortQuery = '';
  bool loadedFeatures = false;
  List<int> selectedFeatureDetailIds = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? campaignBannerUrl;

  bool specialRequest = false;
  String? catTitle;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    getCategoryLink = widget.categoryLink;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resulList = [];
      fetchData();
    });

    controller!.addListener(() {
      if (controller!.position.maxScrollExtent == controller!.offset) {
        loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    resulList = [];
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      offset = controller!.position.pixels;
    });
    widget.setOffsetMethod(controller!.position.pixels);
  }

  void callback(val) async {
    widget.callback!;
  }

  void orderProductList(orderType) async {
    setState(() {
      sortBy = orderType;
    });
    fetchData();
  }

  _applyFilter() async {
    fetchData();
    Navigator.pop(context);
  }

  fetchData() async {
    if (sortBy != null) {
      switch (sortBy) {
        case "DESC":
          sortQuery = "&s_created=desc";
          break;
        case "RECOMMENDED":
          sortQuery = "&s_sorted=desc";
          break;
        case "ASC_PRICE":
          sortQuery = "&s_prices-satisFiyati=asc";
          break;
        case "DESC_PRICE":
          sortQuery = "&s_prices-satisFiyati=desc";
          break;
        default:
      }
    } else {
      sortQuery = '';
    }
    if (selectedFeatureDetailIds.length > 0) {
      sortQuery +=
          "&f_m_info-features-detailIds=" + selectedFeatureDetailIds.join('|');
    }

    getDataSize = int.parse(
        _startController.getSettings('mobile_app', 'product_list_length'));

    campaignBannerUrl = _startController.getSettings(
        'site_settings', 'product_campaign_banner');
    var result;
    if (widget.searchQuery != null) {
      sortQuery += "q_standart=" + widget.searchQuery!;
    }

    if (widget.smellTestIds != null) {
      sortQuery +=
          "&m_m_info-features-detailIds=" + widget.smellTestIds!.join('|');
      specialRequest = true;
    }
    result = await _productController.getCategoryInfoByLink(
        getCategoryLink, getDataSize,
        sortQuery: sortQuery, specialRequest: specialRequest);

    if (result != null) {
      productCategoryData = _productController.categoryData.value;
      catTitle = PublicFunctions.returnCategoryLang(productCategoryData);
      hasSubCategory = productCategoryData.children != null &&
              productCategoryData.children!.length > 0
          ? true
          : false;

      resulList = result['data'];
      setState(() {
        totalPage = result['last_page'];
        currentPage = 1;
        hasMore = currentPage < totalPage ? true : false;
      });
    }
  }

  loadMore() async {
    currentPage += 1;
    if (currentPage <= totalPage) {
      setState(() {
        loader = true;
      });
      var query = "";
      if (widget.categoryLink != null &&
          widget.categoryLink != "yeni-gelenler") {
        query += "f_m_info-categories-id=";
        query = query + _productController.catIds.value.join('|');
      } else {
        query = "";
      }
      query += sortQuery;
      query += "&length=" +
          getDataSize.toString() +
          "&page=" +
          currentPage.toString();

      var result = await _productController.getLoadMore(query);

      setState(() {
        loader = false;
        resulList += result['data'];
      });
    } else {
      PublicFunctions.showMessage('Tüm Ürünler yüklendi...', type: 'dark');
    }
    hasMore = currentPage < totalPage ? true : false;
  }

  Future getProductFeatures() async {
    setState(() {
      featureLoader = true;
    });
    _scaffoldKey.currentState!.openEndDrawer();
    await _productController.getProductFeatures(productCategoryData.id);

    setState(() {
      featureLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_productController.isListLoading.value) {
        return ProductListSK(
          search: widget.searchQuery != null ? true : false,
        );
      } else {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return shouldPop;
          },
          child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: loader
                  ? Material(
                      elevation: 10,
                      color: AppColors.dark,
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.white,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(AppColors.dark),
                            )),
                      ))
                  : SizedBox(),
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: productCategoryData != null &&
                        productCategoryData.title != null
                    ? Text(
                        catTitle ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: catTitle != null && catTitle!.length < 35
                                ? 18
                                : 15),
                      )
                    : SizedBox(),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => ProductSearch());
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.white,
                      )),
                  Row(
                    children: [
                      Material(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              orjinalShow ? AppColors.warning : Colors.white24,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              'assets/images/logo/loriso.svg',
                              fit: BoxFit.fitHeight,
                              width: 13,
                              semanticsLabel: 'Acme Logo',
                              color:
                                  orjinalShow ? Colors.white : Colors.white30,
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Switch(
                        value: orjinalShow,
                        onChanged: (value) {
                          setState(() {
                            orjinalShow = value;
                          });
                        },
                        inactiveTrackColor: Colors.white24,
                        inactiveThumbColor: AppColors.white,
                        activeTrackColor: AppColors.warning,
                        activeColor: AppColors.white,
                      ),
                    ],
                  )
                ],
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(40.0),
                    child: _filterContainer(context)),
              ),
              key: _scaffoldKey,
              endDrawer: SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Drawer(child: _endDraverInner(context)),
              ),
              body: _productList(context)),
        );
      }
    });
  }

  _endDraverInner(context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    List<Container> _contList = [];

    _productController.featureList.forEach((element) {
      _contList.add(Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.light,
                  border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.lightdark),
                    top: BorderSide(width: 1, color: AppColors.lightdark),
                  ),
                ),
                child: Text(
                  element.title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 50.0,
                maxHeight: 200.0,
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ...element.productFeatureDetails!.map((item) {
                      return SizedBox(
                          height: 40,
                          child: CheckboxListTile(
                            checkColor: AppColors.white,
                            activeColor: AppColors.dark,
                            title: Text(item.title!),
                            value: selectedFeatureDetailIds.contains(item.id),
                            onChanged: (value) {
                              if (value!) {
                                setState(() {
                                  selectedFeatureDetailIds.add(item.id!);
                                });
                              } else {
                                setState(() {
                                  selectedFeatureDetailIds.remove(item.id!);
                                });
                              }
                            },
                          ));
                    }).toList()
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    });
    if (!featureLoader) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: statusBarHeight),
                color: AppColors.white,
                width: double.infinity,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 10,
                      child: Text('FİLTRELER',
                          style: AppColors.darkT(size: 16, bold: true)),
                    ),
                    if (selectedFeatureDetailIds.length > 0)
                      Positioned(
                        top: 15,
                        left: 90,
                        child: Material(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.dark,
                          child: Container(
                            width: 20,
                            height: 20,
                            child: Text(
                              selectedFeatureDetailIds.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                            ),
                          ),
                        ),
                      ),
                    if (selectedFeatureDetailIds.length > 0)
                      Positioned(
                        top: 10,
                        right: 22,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedFeatureDetailIds = [];
                            });
                            fetchData();
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(23),
                            color: AppColors.dark,
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                )),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 50),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[..._contList.map((item) => item).toList()],
                ),
              ),
            )),
            if (selectedFeatureDetailIds.length > 0)
              Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _applyFilter,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        primary: AppColors.dark,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                      ),
                      child: Text(
                        'UYGULA',
                        style: AppColors.whiteT(bold: true, size: 20),
                      )))
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.dark))),
            SizedBox(
              height: 30,
            ),
            Container(child: Text('Filreler yükleniyor...')),
          ],
        ),
      );
    }
  }

  _productList(context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      // margin: EdgeInsets.only(bottom: 10),
      height: double.infinity,
      child: GridView.builder(
        itemCount: resulList.length,
        shrinkWrap: true,
        controller: controller,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          height: 400,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index < resulList.length) {
            return ProductItem(
              product: resulList[index],
              callback: callback,
              type: 1,
              showOriginalImage: orjinalShow,
              buttonLoader: buttonLoader,
              shoppingStatus: shoppingStatus,
              showPrice: true,
              labelBanner: campaignBannerUrl,
              key: Key(resulList[index]['_id']),
              isFavori: favoritesAll != null && favoritesAll.length > 0
                  ? favoritesAll.contains(resulList[index]['_id'])
                  : false,
              prefix: 'product_list',
              offset: widget.getOffsetMethod(),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  _filterContainer(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: AppColors.light),
      child: Row(
        children: <Widget>[
          hasSubCategory
              ? Expanded(
                  flex: 3,
                  child: InkWell(
                      onTap: () {
                        _subCategoryBottomSheet(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.subject,
                                color: AppColors.dark,
                              )),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'KATEGORİLER',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark,
                              ),
                            ),
                          )
                        ],
                      )),
                )
              : Expanded(flex: 0, child: SizedBox()),
          Expanded(
            flex: 2,
            child: InkWell(
                onTap: () {
                  _sortBottomSheet(context);
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.sort,
                          color: AppColors.dark,
                        )),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'SIRALA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
                onTap: () {
                  getProductFeatures();
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Icon(Icons.filter_list, color: AppColors.dark)),
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Text(
                            'FİLTRELE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.dark,
                            ),
                          ),
                          selectedFeatureDetailIds.length > 0
                              ? Positioned(
                                  left: 60,
                                  top: 0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.dark,
                                    elevation: 1,
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _sortBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              child: Wrap(
            children: <Widget>[
              Container(
                  decoration: AppColors.boxDecorationBorderBottom,
                  child: ListTile(
                      leading: Icon(
                        Icons.update,
                        color: AppColors.dark,
                      ),
                      title: Text(
                        widget.categoryLink == "yeni-gelenler"
                            ? 'Önce En Eskiler'
                            : 'Önce En Yeniler',
                        style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        orderProductList('DESC');
                        Navigator.pop(context);
                      })),
              Container(
                  decoration: AppColors.boxDecorationBorderBottom,
                  child: ListTile(
                      leading: Icon(
                        Icons.favorite_border,
                        color: AppColors.dark,
                      ),
                      title: Text(
                        'Tavsiye Edilen',
                        style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        orderProductList('RECOMMENDED');

                        Navigator.pop(context);
                      })),
            ],
          ));
        });
  }

  void _subCategoryBottomSheet(context) {
    ProductList myPlist = ProductList();

    List<ProductCategoryData> subCat = productCategoryData.children!;

    List<Container> subCatList = [];
    subCatList.add(Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.light,
        ),
        child: Text(
          'ALT KATEGORİLER',
          style: TextStyle(fontWeight: FontWeight.w600),
        )));
    subCat.forEach((cat) {
      subCatList.add(Container(
          decoration: AppColors.boxDecorationBorderBottom,
          child: ListTile(
              leading: new Icon(Icons.chevron_right, color: AppColors.dark),
              title: new Text(
                cat.title!,
                style: TextStyle(
                    color: AppColors.dark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);

                setState(() {
                  getCategoryLink =
                      cat.productCategoryInfos!.first.link!.substring(1) + '_c';
                });

                fetchData();
              })));
    });
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              child: Wrap(
            children: subCatList,
          ));
        });
  }
}
