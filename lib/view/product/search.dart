import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/general/CustomButtons.dart';
import '../../utilities/publicFunction.dart';
import '/theme/appColors.dart';

import '../../components/general/pageChangeAnimation.dart';

import '../../view/product/productList.dart';

final keys = new GlobalKey<_ProductSearchState>();

class ProductSearch extends StatefulWidget {
  final String? categoryLink;
  ProductSearch({Key? key, this.categoryLink}) : super(key: keys);

  double getOffsetMethod() {
    return offset;
  }

  void setOffsetMethod(double val) {
    offset = val;
  }

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  String? search;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _runApp(context);
  }

  _runApp(context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: PreferredSize(
                  child: Container(
                      color: AppColors.light,
                      height: 50.0,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          Navigator.of(context).push(SlideRightRoute(
                              page: ProductList(
                            searchQuery: value,
                          )));
                        },
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                        validator: (arg) {
                          if (arg!.length < 3)
                            return 'Min 2 karakter giriniz.';
                          else
                            return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: AppColors.light,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.success,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                      )),
                  preferredSize: Size.fromHeight(50.0)),
              title: Text('ÜRÜN ARA'),
            ),
            body: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.dark,
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Center(
                                  child: Icon(
                                Icons.search,
                                size: 50,
                                color: AppColors.white,
                              )),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Text('ÜRÜN ARA',
                            style: TextStyle(
                                color: AppColors.dark,
                                fontSize: 22,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aradığınız ürünü şimdi bulun',
                          style: TextStyle(letterSpacing: 2),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: CustomBigButton(
                            loader: false,
                            title: "ARAMAYA BAŞLA",
                            onPressed: () {
                              if (search == null || search!.length < 2) {
                                PublicFunctions.showMessage(
                                    'Arama için en az 3 karakter giriniz.',
                                    setlocation: 'top');
                              } else
                                Navigator.of(context).push(SlideRightRoute(
                                    page: ProductList(
                                  searchQuery: search,
                                )));
                            },
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    )))));
  }
}
