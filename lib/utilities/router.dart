import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loris_bussiness/utilities/publicFunction.dart';

import '../cons/routePath.dart';
import '../view/general/content.dart';
import '../view/product/smelltest.dart';
import '/view/index.dart';
import '/view/product/productDetail.dart';
import '/view/product/productList.dart';

class ProjectRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return MaterialPageRoute(builder: (_) => Index());
      case RoutePath.home2:
        return MaterialPageRoute(builder: (_) => Index());

      default:
        {
          var result = getUrl(settings.name);
          print(result['url']);
          if (result['url'] == 'smell-test' || result['url'] == '/koku_testi') {
            return MaterialPageRoute(
                builder: (context) => SmellTest(
                      showBack: true,
                    ));
          }
          if (result['type'] == 'category') {
            return MaterialPageRoute(
                builder: (context) => ProductList(
                      categoryLink: result['data'],
                    ));
          } else if (result['type'] == 'product') {
            return MaterialPageRoute(
                builder: (context) => ProductDetail(
                      productID: result['data'],
                    ));
          } else if (result['type'] == 'product-link') {
            return MaterialPageRoute(
                builder: (context) => ProductDetail(
                      productLink: result['data'],
                    ));
          } else if (result['type'] == 'content') {
            return MaterialPageRoute(
                builder: (context) => Content(
                      id: result['data'],
                    ));
          } else {
            return MaterialPageRoute(builder: (context) => Index());
          }
        }
    }
  }

  static Map getUrl(url) {
    var returnData = {};
    String? type;
    String? data;

    Uri _uri = Uri.parse(url);
    if (_uri.path != "" && _uri.path[0] == '/') {
      List<String> path = _uri.path.split('/');
      List<String> pathIn = path.last.split('_');
      if (pathIn.length > 1) {
        if (pathIn.last == 'c') {
          type = 'category';
          data = path.last;
        }
        if (pathIn.last == 'p') {
          type = 'content';
          data = pathIn.first;
        }
        if (pathIn.last.length > 2) {
          type = 'product';
          data = pathIn.last;
        }
      } else {
        if (pathIn.first == "yeni-gelenler") {
          type = 'category';
          data = pathIn.first;
        } else {
          type = 'product-link';
          data = pathIn.first;
        }
      }

      if (path[1] == "contents") {
        type = 'content';
        data = PublicFunctions.isNumeric(path[2]) ? path[2] : path[3];
        url = url;
      }

      if (path[1] == "ct") {
        type = 'cargoTrace';
        data = _uri.queryParameters["oc"]!;
        url = url;
      }

      if (path[1] == "user" && path[2] == "orders" && path[3] == "detail") {
        type = 'orderDetail';
        data = path[4];
        url = url;
      }

      if (url.substring(0, 4) == 'http') {
        type = 'link';
        data = url;
      }
    }
    returnData['data'] = data;
    returnData['type'] = type;
    returnData['url'] = url;

    return returnData;
  }
}
