import '/components/skeleton/productItemSK.dart';
import 'package:flutter/material.dart';
import '/theme/appColors.dart';

import '../grid.dart';
import 'generalSK.dart';

class ProductListSK extends StatelessWidget {
  final String? type;
  final String? pageType;
  final bool? search;
  const ProductListSK({Key? key, this.type, this.search, this.pageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return _scaffold(context);
  }

  _scaffold(context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: SkeletonContainer.square(
            width: 170,
            height: 25,
          ),
          bottom: pageType == null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(40.0),
                  child: _filterContainer(context))
              : PreferredSize(
                  preferredSize: Size.fromHeight(0.0), child: SizedBox()),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          margin: EdgeInsets.only(bottom: 10),
          height: double.infinity,
          child: GridView.builder(
            itemCount: 12,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              height: 400,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductItemSK();
            },
          ),
        ));
  }

  _filterContainer(context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: AppColors.light),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.sort,
                        color: AppColors.grey.withOpacity(0.3),
                      )),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'SIRALA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                    ),
                  )
                ],
              )),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Icon(Icons.filter_list,
                          color: AppColors.grey.withOpacity(0.3))),
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        Text(
                          'FİLTRELE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ),
          ],
        ));
  }

  _justList(context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          height: 400,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductItemSK();
        },
      ),
    );
  }
}
