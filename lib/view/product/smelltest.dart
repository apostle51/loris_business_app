import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loris_bussiness/view/product/productList.dart';

import '../../components/general/CustomButtons.dart';
import '../../components/general/pageChangeAnimation.dart';
import '../../components/loader.dart';
import '../../cons/general.dart';
import '../../controller/productController.dart';
import '../../controller/startController.dart';
import '../../model/product/productFeaturesData.dart';
import '../../theme/AppColors.dart';

class SmellTest extends StatefulWidget {
  bool? showBack;
  SmellTest({
    Key? key,
    this.showBack,
  });
  @override
  _SmellTestState createState() => _SmellTestState();
}

int itemNumber = 0;

final _controller = new PageController();
const _kDuration = const Duration(milliseconds: 300);
const _kCurve = Curves.ease;
bool loader = true;
List selectedFeature = [];
final _startController = StartController.to;
final _productController = ProductController.to;
var pageListSettings;
String? bannerGroupId;

class _SmellTestState extends State<SmellTest> {
  List<Widget> pages = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
    super.initState();
  }

  _fetch() async {
    bannerGroupId = _startController.getSettings(
        'business_app', 'koku_testi_banner_group_id');
    if (bannerGroupId != null) {
      await _productController.getProductFeaturesAll(null);
      await _startController.getBannerGroupsByBannerGroupId(bannerGroupId);

      setState(() {
        loader = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loader = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Koku Testi'),
        leading: !widget.showBack!
            ? SizedBox()
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (selectedFeature.length > 0) {
                    setState(() {
                      selectedFeature = [];
                    });

                    _controller.jumpTo(0);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
      ),
      body: _createInex(),
    );
  }

  _createInex() {
    return Obx(() {
      if (_startController.isInnerLoading.value) {
        return LinearIndicatorLoader();
      } else {
        if (loader) {
          return LinearIndicatorLoader();
        } else {
          pages = [];
          pageListSettings =
              _startController.getSettings('business_app', 'koku_testi_order');

          pageListSettings = pageListSettings.split(',');

          pages.add(FirstStep());

          if (pageListSettings.length > 0) {
            for (var i = 0; i < pageListSettings.length; i++) {
              pages.add(DynamicParfumTest(
                getFauter: pageListSettings[i],
                no: i,
              ));
            }
          }
          return PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            children: pages,
            scrollDirection: Axis.horizontal,
            pageSnapping: false,
          );
        }
      }
    });
  }
}

// ignore: must_be_immutable
class DynamicParfumTest extends StatefulWidget {
  final String? getFauter;
  int? no;
  DynamicParfumTest({this.getFauter, this.no});
  @override
  _DynamicParfumTestState createState() => _DynamicParfumTestState();
}

class _DynamicParfumTestState extends State<DynamicParfumTest> {
  bool hasInData = false;
  bool isLast = false;
  String? title;
  @override
  Widget build(BuildContext context) {
    isLast = (pageListSettings.length - 1 == widget.no) ? true : false;
    _productController.featureListAll.value.forEach((feature) {
      if (feature.id == int.parse(widget.getFauter!)) {
        title = feature.title;
      }
    });

    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: 'Urbanist',
              ),
              children: <TextSpan>[
                TextSpan(
                    text: title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                  text: ' Seçiniz',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Wrap(
            runSpacing: 0,
            spacing: 15,
            children: _getProductFeatureAreaIn(widget.getFauter),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              _controller.previousPage(duration: _kDuration, curve: _kCurve);
            },
            child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(100),
                color: AppColors.dark,
                child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Icon(
                    Icons.chevron_left,
                    size: 20,
                    color: AppColors.white,
                  )),
                )),
          )
        ]),
      ),
    );
  }

  List<Widget> _getProductFeatureAreaIn(id) {
    List<Container> rowList = [];

    _productController.featureListAll.forEach((feature) {
      if (feature.id == int.parse(id)) {
        feature.productFeatureDetails!.forEach((fin) {
          String? imagePath = _getBanner(fin.id);
          bool show = true;
          if (selectedFeature.contains(74)) {
            List ids = [367, 369, 81, 373];
            if (ids.contains(fin.id)) show = false;
          }
          if (selectedFeature.contains(75)) {
            List ids = [371, 372, 80, 82];
            if (ids.contains(fin.id)) show = false;
          }
          if (imagePath != null && show) {
            rowList.add(Container(
                width: (MediaQuery.of(context).size.width - 40) / 2,
                // margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    _onCategorySelected(true, fin.id);
                    setState(() {
                      hasInData = selectedFeature.contains(fin.id);
                    });
                    if (hasInData) {
                      if (isLast) {
                        Navigator.of(context).push(SlideRightRoute(
                            page: ProductList(
                          smellTestIds: selectedFeature,
                        )));
                      } else {
                        setState(() {
                          itemNumber++;
                        });

                        _controller.nextPage(
                            duration: _kDuration, curve: _kCurve);
                      }
                    }
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: KokuTestiBanner(
                    feature: fin,
                    imagePath: imagePath,
                  ),
                )));
          }
        });
      }
    });
    return rowList;
  }

  _getBanner(id) {
    var value;

    if (id != null) {
      _startController.kokuTestiBanners.forEach((v) {
        if (v['custom_val1'] == id.toString()) {
          value = v['file_path'];
        }
      });

      return value;
    }
  }

  void _onCategorySelected(bool selected, featureId) {
    if (selected == true) {
      setState(() {
        selectedFeature.add(featureId);
      });
    } else {
      setState(() {
        selectedFeature.remove(featureId);
      });
    }
  }
}

class KokuTestiBanner extends StatefulWidget {
  final ProductFeaturesData? feature;
  final String? imagePath;
  KokuTestiBanner({this.feature, this.imagePath});

  @override
  _KokuTestiBannerState createState() => _KokuTestiBannerState();
}

class _KokuTestiBannerState extends State<KokuTestiBanner> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: Colors.black87,
      elevation: 16,
      shadowColor: Color(0xFF000000),
      child: Container(
        height: 250,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Stack(
              children: <Widget>[
                Text(widget.feature!.title.toString()),
                ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ).createShader(Rect.fromLTRB(0.0, 30, 20, 220.0));
                    },
                    blendMode: BlendMode.hardLight,
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              GeneralCons.imageUrl + widget.imagePath!),
                          fit: BoxFit.cover),
                    ))),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Text(
                    widget.feature!.title.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2),
                            blurRadius: 3.0,
                            color: Colors.black54,
                          ),
                        ],
                        fontSize: widget.feature!.title!.length > 13 ? 16 : 20),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class FirstStep extends StatefulWidget {
  @override
  _FirstStepState createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Koku ',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: 'Urbanist',
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Testi',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: ' İle',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontFamily: 'Urbanist',
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'KOKUNU',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' BUL'),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Sizin için en doğru kokuyu bulmaya hazırmısınız ?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomBigButton(
                onPressed: () {
                  setState(() {
                    itemNumber++;
                  });
                  _controller.nextPage(duration: _kDuration, curve: _kCurve);
                },
                title: "ŞİMDİ BAŞLA",
                color: AppColors.black,
                loader: loader),
          ),
          Text(
            'Seçimlerinizi yapın sizin içi en doğru kokuyu hızlıca bulun.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white60, letterSpacing: 1),
          ),
          SizedBox(height: 80)
        ]),
      ),
    );
  }
}
