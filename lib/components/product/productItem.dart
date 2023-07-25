import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as image;

import '../../cons/general.dart';
import '../../model/product/product.dart';
import '../../utilities/publicFunction.dart';
import '/theme/appColors.dart';
import '/view/product/productDetail.dart';

class ProductItem extends StatefulWidget {
  final Function? favorite;
  final Function? addToCart;
  final Function? changeAmountToCart;

  bool isFavori;
  bool? buttonLoader;
  bool showPrice;
  int? groupId;
  int? type;
  bool? showOriginalImage;
  bool? stockControlStatus;
  String? prefix;
  bool? shoppingStatus;
  String? labelBanner;

  var product;
  final Function(double offset)? callback;
  var offset;

  ProductItem(
      {Key? key,
      this.product,
      this.favorite,
      this.buttonLoader,
      this.shoppingStatus,
      this.changeAmountToCart,
      this.showOriginalImage,
      this.stockControlStatus,
      this.addToCart,
      this.groupId,
      required this.type,
      required this.showPrice,
      required this.isFavori,
      this.labelBanner,
      this.prefix,
      this.callback,
      this.offset})
      : super(key: key);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductItemData productItem = ProductItemData();
  bool favori = false;
  bool showOriginImage = false;
  bool hasOriginImage = false;
  bool shoppingStatus = true;
  bool pressed = false;
  bool pressedChangeAmount = false;
  bool pressedFavorite = false;
  bool showPriceArea = false;
  String? productCode;
  bool isPackage = false;
  int localAmount = 0;
  int _current = 0;
  int amount = 1;
  String? totalPackagedPrice;
  late int realQuantity = 1;
  late int totalStock;
  var seotitle;
  bool amountEdit = false;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  fetchData() async {
    productItem = ProductItemData.fromJson(widget.product);
    if (productItem.images!.length > 1) {
      //productItem.images!.removeLast();
    }
    if (productItem.info!.sameBrand != null &&
        productItem.info!.sameBrand!.refBrand != null &&
        productItem.info!.sameBrand!.refBrandDetail != null) {
      hasOriginImage = true;
      showOriginImage = widget.showOriginalImage!;
    }

    amount = int.parse(productItem.stock!.minOrderQuantity!);
    favori = widget.isFavori != null ? widget.isFavori : false;
    realQuantity = int.parse(productItem.stock!.realQuantity!);

    if (realQuantity > 1) {
      isPackage = true;
    }
    if (widget.stockControlStatus != null &&
        widget.stockControlStatus == true) {
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

    productCode =
        productItem.stock != null && productItem.stock!.productCode != null
            ? productItem.stock!.productCode
            : null;
    seotitle = productItem.info!.seoTitle != null
        ? (productItem.info!.seoTitle.toString().length > 26
            ? productItem.info!.seoTitle.toString().substring(0, 26) + '...'
            : productItem.info!.seoTitle.toString())
        : '';
    if (shoppingStatus)
      shoppingStatus = totalStock > 0 ? shoppingStatus : false;

    showPriceArea =
        (productItem.master!.stockStatus.toString() == "1") ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return productItem.id != null && productItem.images != null
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            product: widget.product,
                            showOriginalImage: widget.showOriginalImage,
                            offset: double.parse(widget.offset.toString()),
                          ))).then((value) {
                if (value != null && value['favori'] != null) {
                  if (this.mounted) {
                    setState(() {
                      favori = value['favori'];
                    });
                  }
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
                    left: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
                    right: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
                    bottom: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
                  )),
              child: widget.type == 1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [productImageArea(), productInfoArea()],
                    )
                  : Row(
                      children: [
                        Expanded(flex: 4, child: productImageArea()),
                        Expanded(flex: 7, child: productInfoArea())
                      ],
                    ),
            ),
          )
        : SizedBox();
  }

  productImageArea() {
    var firstImage =
        productItem.images != null && productItem.images!.length > 0
            ? productItem.images!.first.path.toString()
            : null;
    var lastImage = productItem.images != null && productItem.images!.length > 0
        ? productItem.images!.last.path.toString()
        : null;

    return firstImage != null || lastImage != null
        ? Stack(
            children: [
              Container(
                  height: 330,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(GeneralCons.imageUrl +
                            (widget.showOriginalImage!
                                ? lastImage.toString()
                                : firstImage.toString()) +
                            '?s=medium'),
                        fit: BoxFit.cover),
                  )),
              if (productCode != null)
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Material(
                      color: AppColors.black,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          productCode!,
                          style: AppColors.whiteT(size: 13, bold: true),
                        ),
                      )),
                ),
            ],
          )
        : SizedBox();
  }

  productInfoArea() {
    String title = productItem.info!.seoTitle!;
    String originTitle = productItem.info!.sameBrand != null
        ? productItem.info!.sameBrand!.refBrand != null
            ? productItem.info!.sameBrand!.refBrand!
            : ''
        : '';

    originTitle = originTitle +
        (productItem.info!.sameBrand != null
            ? productItem.info!.sameBrand!.refBrandDetail != null
                ? " / " + productItem.info!.sameBrand!.refBrandDetail!
                : ''
            : '');
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              margin: EdgeInsets.only(top: 5),
              child: Center(
                child: Text(
                    PublicFunctions.limitText(
                        widget.showOriginalImage! ? originTitle : title, 42),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.dark,
                        height: 1.3)),
              )),
        ],
      ),
    );
  }
}
