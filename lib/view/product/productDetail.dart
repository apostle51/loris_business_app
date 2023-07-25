import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../components/general/design.dart';
import '../../components/grid.dart';
import '../../components/product/productItem.dart';
import '../../cons/general.dart';
import '../../controller/productController.dart';
import '../../controller/startController.dart';
import '../../model/product/product.dart';
import '../../utilities/publicFunction.dart';
import '/components/general/pageChangeAnimation.dart';
import '/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/components/general/HtmlView.dart';
import '/theme/appColors.dart';
import 'package:flutter/src/widgets/image.dart' as image;

class ProductDetail extends StatefulWidget {
  var product;

  final String? productID;
  final String? productLink;
  bool? showOriginalImage;

  final Function(double offset)? callbackOffset;
  final Function? callback;
  final double? offset;

  ProductDetail(
      {Key? key,
      this.product,
      this.callbackOffset,
      this.callback,
      this.productID,
      this.showOriginalImage,
      this.productLink,
      this.offset})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

final _productController = ProductController.to;
final _startController = StartController.to;

class _ProductDetailState extends State<ProductDetail> {
  ProductItemData productItem = ProductItemData();
  ScrollController scrollController = ScrollController();

  late double height;
  bool appBarSetWhite = false;
  bool favori = false;
  bool buttonLoading = false;
  int cartCount = 0;
  String? totalPackagedPrice;
  bool pressedFavorite = false;
  bool stockControlStatus = true;
  bool isFavori = false;
  List resulList = [];
  bool showPriceArea = false;
  bool isPackage = false;
  int amount = 0;
  int realQuantity = 1;
  late int totalStock;
  int? groupId;
  bool amountEdit = false;
  FocusNode _focus = new FocusNode();

  late String _cargoTime;
  late String _cargoPrice;
  late String _freeCargoPriceLimit;

  String _selectedSerialId = 'default';

  String? campaignBannerUrl;
  late double statusBarHeight;
  List size = [1080, 1620];
  bool loader = true;
  int currentAmount = 0;

  var returnData;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resulList = [];

      _fetchData();
    });
    super.initState();
  }

  Map getRequestRecomendedBody = {
    'identical': {},
    'opposite': {'gender': []},
    'settings': {"exclude": '', "random": true, "limit": 10}
  };

  _fetchData() async {
    setState(() {
      loader = true;
    });

    stockControlStatus =
        _startController.getSettings('stock', 'stock_control_status') == "false"
            ? false
            : true;

    productItem = ProductItemData();

    if (widget.productLink != null) {
      productItem =
          await _productController.getProductWithLink(widget.productLink);
    } else {
      productItem = await _productController.getProduct(widget.productID,
          product: widget.product);
    }

    if (!widget.showOriginalImage! && productItem.images!.length > 1) {
      productItem.images!.removeLast();
    }
    await setData();

    getRequestRecomendedBody['identical']
        ['category'] = [productItem.info!.masterCategory!.id];
    getRequestRecomendedBody['settings']['limit'] = 10;
    getRequestRecomendedBody['settings']['random'] = true;
    getRequestRecomendedBody['settings']['exclude'] = productItem.id;
    var result =
        await _productController.getRecommended(getRequestRecomendedBody);
    resulList = result['data'];

    amount = int.parse(productItem.stock!.minOrderQuantity!);
    realQuantity = int.parse(productItem.stock!.realQuantity!);

    if (realQuantity > 1) {
      isPackage = true;
      amount = realQuantity;
    }

    if (stockControlStatus != null && stockControlStatus == true) {
      totalStock = productItem.stockToProducts!.length > 0
          ? (productItem.stockToProducts![0].totalInStock! -
              productItem.stockToProducts![0].totalInOrder! -
              productItem.stockToProducts![0].totalSaled!)
          : 0;
    } else {
      totalStock = 10000;
    }

    totalPackagedPrice =
        (double.parse(productItem.prices!.satisFiyati.toString()) *
                realQuantity)
            .toString();
    setState(() {
      loader = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  setData() async {
    campaignBannerUrl = _startController.getSettings(
        'site_settings', 'product_campaign_banner');

    _cargoTime = _startController.getSettings('general', 'standartCargoTime');
    _cargoPrice =
        _startController.getSettings('checkout', 'base_price_for_shipping');
    _freeCargoPriceLimit = _startController.getSettings(
        'checkout', 'base_price_for_free_shipping');
  }

  bool imageDStart = false;
  @override
  Widget build(BuildContext context) {
    height = ((size[1] * MediaQuery.of(context).size.width) / size[0]);
    double statusBarHeights = MediaQuery.of(context).padding.top;

    return Obx(() {
      if (_productController.isLoading.value ||
          productItem.id == null ||
          loader) {
        return Scaffold(
            body: Container(
                margin: EdgeInsets.only(top: statusBarHeights),
                child: LinearIndicatorLoader()));
      } else {
        return WillPopScope(
            onWillPop: () {
              returnData = {'favori': isFavori};
              if (widget.offset != null && widget.callback != null) {
                widget.callback!(widget.offset!);
              } else {
                widget.callback!(false);
              }
              Navigator.pop(context, returnData);
              return Future.value(false);
            },
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: Get.height / 1.6,
                            child: Stack(
                              children: [
                                Container(
                                  height: Get.height / 1.6,
                                  child: Material(
                                    elevation: 5,
                                    color: AppColors.white,
                                    child: Container(child: _imageArea()),
                                  ),
                                ),
                                Positioned(
                                    top: Get.height / 1.6 - 70,
                                    right: 5,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.dark,
                                      shadowColor: Colors.black,
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 25),
                                        child: Text(
                                            productItem.stock!.productCode!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  PublicFunctions.limitText(
                                      productItem.info?.seoTitle, 135),
                                  style: AppColors.darkT(
                                      size: productItem.info!.seoTitle!.length >
                                              65
                                          ? 16
                                          : 18),
                                ),
                                productItem.info!.brand != null
                                    ? Text(
                                        productItem.info!.brand!.brandName!,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black38, height: 1.3),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          SizedBox(height: 15),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'ÜRÜN BİLGİLERİ' +
                                    productItem.info!.detail!.length.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            height: productItem.info!.detail!.length > 500
                                ? productItem.info!.detail!.length > 750
                                    ? 300
                                    : 150
                                : 130,
                            padding: const EdgeInsets.all(10),
                            child: HtmlView(
                              htmlData: productItem.info!.detail.toString(),
                              size: 16,
                              lineHeight: 1.6,
                            ),
                          ),

                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'BENZER ÜRÜNLER',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                              )),

                          Container(
                            height: 420,
                            padding: EdgeInsets.all(5),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: resulList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    width: 250,
                                    child: ProductItem(
                                      product: resulList[index],
                                      type: 1,
                                      showOriginalImage:
                                          widget.showOriginalImage,
                                      showPrice: true,
                                      labelBanner: campaignBannerUrl,
                                      key: Key(resulList[index]['_id']),
                                      isFavori: false,
                                      prefix: 'product_list',
                                    ),
                                  );
                                }),
                          ),
                          // Container(child: _getRecommended())
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.statusBarHeight,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        returnData = {'favori': isFavori};
                        Navigator.of(context).pop(returnData);
                        if (widget.offset != null && widget.callback != null) {
                          widget.callback!(widget.offset!);
                        }
                      },
                      child: Material(
                        elevation: 4,
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 35,
                          width: 35,
                          child: Icon(
                            Icons.arrow_back,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }
    });
  }

  _imageArea() {
    return productItem.images != null
        ? Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: productItem.images!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return FadeInImage.assetNetwork(
                        fadeInDuration: Duration(milliseconds: 200),
                        fadeOutDuration: Duration(milliseconds: 100),
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/banner/homebanner.png',
                        placeholderScale: 50,
                        image: GeneralCons.imageUrl + i.path! + '?s=large',
                      );
                    },
                  );
                }).toList(),
              ),
            ))
        : SizedBox();
  }
}
