import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loris_bussiness/controller/productController.dart';
import 'package:loris_bussiness/utilities/router.dart';
import 'package:loris_bussiness/view/start.dart';
import 'package:overlay_support/overlay_support.dart';

import 'cons/general.dart';
import 'controller/startController.dart';
import 'theme/light.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(StartController());
  Get.put(ProductController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: GeneralCons.appName,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: ProjectRouter.generateRoute,
        theme: LightTheme.themeDatas(),
        home: StartApp(),
      ),
    );
  }
}
