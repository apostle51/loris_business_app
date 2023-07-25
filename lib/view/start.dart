import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../components/loader.dart';
import '../controller/startController.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class StartApp extends StatefulWidget {
  StartApp({Key? key}) : super(key: key);

  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  final _startController = StartController.to;
  late int introBannerGroupID;
  bool loader = true;
  bool startIntro = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() async {
    await _startController.initStart(context);

    setState(() {
      loader = false;
    });
  }

  authPhoneCallBack(value) async {
    setState(() {
      loader = true;
    });

    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_startController.isFirstLoading.value || loader) {
        return LorisLoader();
      } else {
        return Index();
      }
    });
  }

  // goUrlCheck() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var url = await prefs.getString('goUrl');
  //   await prefs.remove("goUrl");
  //   if (url != null && url != "") Navigator.pushNamed(context, url.toString());
  // }

}
