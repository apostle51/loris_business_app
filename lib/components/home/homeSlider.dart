import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cons/general.dart';
import '../../model/general/banner.dart';

class MainSlider extends StatefulWidget {
  var data;
  MainSlider({this.data});
  @override
  _MainSliderState createState() => _MainSliderState();
}

class _MainSliderState extends State<MainSlider> {
  List<BannerData> _banners = [];
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.data.forEach((i) {
      BannerData item = BannerData.fromJson(i);
      if (int.parse(item.status!) != 0) {
        _banners.add(item);
      }
      //_banners.add(BannerData.fromJson(i));
    });

    return Container(
        height: 360,
        width: double.infinity,
        child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
          ),
          items: _banners.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(alignment: Alignment.topCenter, children: [
                  Positioned(
                      child: GestureDetector(
                    onTap: () {
                      if (i.link != "" && i.link != "/" && i.link != null) {
                        if (i.link!.split('http').length > 1) {
                          _launchURL(i.link.toString());
                        } else {
                          Navigator.pushNamed(
                              context, (i.link != "") ? i.link! : '/',
                              arguments: RouteSettings(name: i.title));
                        }
                      }
                    },
                    child: FadeInImage.assetNetwork(
                      fadeInDuration: Duration(milliseconds: 100),
                      fadeOutDuration: Duration(milliseconds: 100),
                      fit: BoxFit.cover,
                      placeholderScale: 3,
                      placeholder: 'assets/images/banner/homebanner.png',
                      image: GeneralCons.imageUrl + i.filePath!,
                    ),
                  )),
                ]);
              },
            );
          }).toList(),
        ));
  }
}
