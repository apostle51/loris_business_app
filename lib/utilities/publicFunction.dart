import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../model/product/productCategory.dart';
import '/theme/appColors.dart';

class PublicFunctions {
  static String getSettings(settingsData, group, key) {
    var value = '';

    settingsData.forEach((v) {
      if (v['group'] == group && v['key'] == key) {
        value = v['value'];
      }
    });
    return value;
  }

  static String getPriceString(price) {
    String _price = price.toString().split('.')[0];

    String _price_after = price.toString().split('.').length > 1 &&
            price.toString().split('.')[1] != "00" &&
            price.toString().split('.')[1] != "0"
        ? '.' +
            (price.toString().split('.')[1].length == 1
                ? price.toString().split('.')[1] + '0'
                : price.toString().split('.')[1])
        : '';
    return _price +
        (_price_after.length > 3 ? _price_after.substring(0, 3) : _price_after);
  }

  static Widget getPrice(
      {price, currency, size, color, tax, bold, bool? underline}) {
    double _size = size != null ? double.parse(size.toString()) : 14;
    bool _bold = bold != null ? true : false;
    bool _tax = tax != null ? true : false;
    Color _color = color != null ? color : AppColors.grey;
    String _price = price.toString().split('.')[0];

    String _price_after = price.toString().split('.').length > 1 &&
            price.toString().split('.')[1] != "00" &&
            price.toString().split('.')[1] != "0"
        ? '.' +
            (price.toString().split('.')[1].length == 1
                ? price.toString().split('.')[1] + '0'
                : price.toString().split('.')[1])
        : '';

    if (size != null) {}

    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: _size,
            fontFamily: 'Urbanist',
            color: _color,
          ),
          children: <TextSpan>[
            TextSpan(
                text: _price,
                style: TextStyle(
                    fontSize: _size,
                    color: _color,
                    height: 1.2,
                    decoration: underline != null && underline
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontWeight: _bold ? FontWeight.bold : FontWeight.normal)),
            TextSpan(
                text: _price_after.length > 3
                    ? _price_after.substring(0, 3)
                    : _price_after,
                style: TextStyle(
                    fontSize: _size / 1.2,
                    color: _color,
                    height: 1.2,
                    decoration: underline != null && underline
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontWeight: _bold ? FontWeight.bold : FontWeight.normal)),
            TextSpan(
                text: " TL",
                style: TextStyle(
                    fontSize: _size / 1.2,
                    color: _color,
                    height: 1.2,
                    decoration: underline != null && underline
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontWeight: _bold ? FontWeight.bold : FontWeight.normal)),
            _tax
                ? TextSpan(
                    text: " + KDV",
                    style: TextStyle(
                        fontSize: _size / 1.2,
                        color: AppColors.grey,
                        height: 1.2,
                        decoration: underline != null && underline
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight:
                            _bold ? FontWeight.bold : FontWeight.normal))
                : TextSpan(),
          ]),
    );
  }

  static dynamic getUrl(url) {
    var returnData = {};
    String? type;
    String? data;
    if (url[0] == '/') {
      List<String> path = url.split('/');
      List<String> pathIn = path.last.split('_');
      if (pathIn.length > 1) {
        if (pathIn.last == 'c') {
          type = 'category';
        }
        if (pathIn.last == 'p') {
          type = 'content';
        }
        data = pathIn.first;
      } else {
        type = 'product';
        data = pathIn.first;
      }
    } else if (url.substring(0, 4) == 'http') {
      type = 'link';
      data = url;
    }
    returnData['data'] = data;
    returnData['type'] = type;

    return returnData;
  }

  static returnCategoryLang(ProductCategoryData data) {
    var lang = "tr";
    if (lang == "tr") {
      return data.title;
    } else {
      if (data.productCategoryInfos != null &&
          data.productCategoryInfos!.length > 0) {
        return data.productCategoryInfos![0].title;
      } else {
        return data.title;
      }
    }
  }

  static showMessage(msg, {type, setlocation, int? setlength}) {
    Color myColor = AppColors.primary;
    Duration duration = Duration(seconds: setlength == null ? 2 : setlength);

    NotificationPosition gravity = NotificationPosition.bottom;

    if (type != null) {
      if (type == "success") {
        myColor = AppColors.success;
      } else if (type == "danger") {
        myColor = AppColors.danger;
      } else if (type == "info") {
        myColor = AppColors.info;
      } else if (type == "dark") {
        myColor = AppColors.black;
      } else {
        myColor = AppColors.success;
      }
    } else {
      myColor = AppColors.success;
    }
    if (setlocation != null) {
      if (setlocation == "top") {
        gravity = NotificationPosition.top;
      }
      if (setlocation == "center") {
        gravity = NotificationPosition.top;
      }
      if (setlocation == "bottom") {
        gravity = NotificationPosition.bottom;
      }
    }
    return showSimpleNotification(Text(msg),
        position: gravity, background: myColor, duration: duration);
    // final appTitle = 'Styled Toast Example';
    //  toast('this is a message from toast');

    // return Fluttertoast.showToast(
    //     msg: msg != null ? msg : '',
    //     toastLength: length,
    //     gravity: gravity,
    //     backgroundColor: myColor,
    //     textColor: Colors.white,
    //     fontSize: 14.0);
  }

  static double outTax(price, rate) {
    var result = double.parse(price.toString()) /
        (1 + (double.parse(rate.toString()) / 100));
    return double.parse(result.toStringAsExponential(2));
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static String limitText(text, limit) {
    if (text != null && text.length > limit) {
      return text.substring(0, limit) + '...';
    } else if (text != null) {
      return text;
    } else {
      return '';
    }
  }

  static String quantityText(int quantity) {
    switch (quantity) {
      case 2:
        return 'li';
      case 3:
        return 'lü';
      case 4:
        return 'lü';
      case 5:
        return 'li';
      case 6:
        return 'lı';
      case 10:
        return 'lu';
      case 12:
        return 'li';
      case 24:
        return 'lü';
      case 48:
        return 'li';
      case 60:
        return 'lı';
      case 100:
        return 'lü';

      default:
        return 'li';
    }
  }

  static String getProductUnitType(type) {
    if (type == 1) {
      return "Gram";
    }
    if (type == 2) {
      return "Gram";
    } else {
      return "Adet";
    }
  }

  static validationForMail(value, loginType) {
    if (loginType == 0) {
      if (value.isEmpty) {
        return 'Mail Adresininizi giriniz';
      }
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Geçerli bir mail adresi giriniz.';
      }
    } else if (loginType == 1) {
      if (value.isEmpty) {
        return 'Telefon Numarası giriniz';
      }
      if (value.length != 10) {
        return '0 olmadan 10 haneli telefon numarası giriniz';
      }
      if (RegExp(r"/5[0,3,4,5,6][0-9]\d\d\d\d\d\d\d$/").hasMatch(value)) {
        return 'Geçerli bir mail adresi giriniz.';
      }
    }
    return null;
  }
}
