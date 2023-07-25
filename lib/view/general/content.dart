import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/general/HtmlView.dart';
import '../../cons/general.dart';
import '../../controller/startController.dart';
import '../../model/contents/contentsData.dart';
import '/components/loader.dart';

import '/theme/appColors.dart';

class Content extends StatefulWidget {
  String id;
  Content({Key? key, required this.id}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _startController = StartController.to;
  String title = '';
  ContentData content = ContentData();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  var result;
  fetchData() async {
    var result = await _startController.getContent(widget.id);
    setState(() {
      content = result;
      title = content.seoTitle ?? 'asdf';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: _startController.isInnerLoading.value
              ? SizedBox()
              : Text(title.toString()),
        ),
        body: _startController.isInnerLoading.value
            ? LinearIndicatorLoader()
            : Container(
                child:
                    content.id == null ? _noData(context) : _runApp(context))));
  }

  _runApp(context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        if (content.image != null)
          Container(
              child: FadeInImage.assetNetwork(
            fadeInDuration: Duration(milliseconds: 100),
            fadeOutDuration: Duration(milliseconds: 100),
            fit: BoxFit.cover,
            placeholder: 'assets/images/homebanner.png',
            image: GeneralCons.imageUrl + content.image.toString(),
          )),
        HtmlView(
          htmlData: content.text,
          size: 15,
          lineHeight: 1.6,
        ),
      ],
    ));
  }

  _noData(context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Icon(
                    Icons.filter_none,
                    size: 50,
                    color: AppColors.primary,
                  )),
                )),
            SizedBox(
              height: 20,
            ),
            Text('İÇERİK BULAMADIK :(',
                style: TextStyle(
                    color: AppColors.dark,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            Text('Çok üzgünüz, sizin için içerik bulamadık'),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bir sorun oldu şimdilik aşağıdaki buton ile anasayfaya gitmenizi öneriyoruz.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                      color: AppColors.primary,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'ANASAYFAYA GİT',
                            style: AppColors.whiteT(bold: true, size: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
