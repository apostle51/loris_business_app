import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralCons {
  static Map<String, String> sendheaders = {
    HttpHeaders.contentTypeHeader: "application/json",
    "api-token": "MkjvxqPNM36L21vV8tEuJZhtaagd1AZJeqfHO1c8dpBwyNAX3gceuHdjOpPh",
  };
  static var apiUrlFinal = "https://app.lorisparfum.com/";
  static var imageUrl = "https://app.lorisparfum.com/";
  static var appVersion = "1.1.0.18";
  static var appVersionIos = "1.1.0.18";
  static var appVersionAndroid = "1.1.0.18";
  static var siteUrl = "https://lorisparfum.com.com.tr";
  static var appName = "Loriss";
}
