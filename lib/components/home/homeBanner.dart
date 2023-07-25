import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cons/general.dart';
import '../../model/general/banner.dart';

class HomeBanners extends StatefulWidget {
  var data;

  int visualType; //1 tam 2 yarım
  HomeBanners({this.data, required this.visualType});
  @override
  _HomeBannersState createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  var homeBigBanners;
  List<BannerData> _banners = [];
  @override
  void initState() {
    getBanners();

    super.initState();
  }

  void getBanners() {
    widget.data.forEach((i) {
      BannerData item = BannerData.fromJson(i);
      if (int.parse(item.status!) != 0) {
        _banners.add(item);
      }
      //_banners.add(BannerData.fromJson(i));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visualType == 1) {
      return _visualType1(context, _banners);
    } else {
      return _visualType2(context, _banners);
    }
  }

  _visualType1(context, _banners) {
    List<Container> containers = [];
    _banners.forEach((banner) {
      if (int.parse(banner.status) == 1) {
        containers.add(_getBannerView(context, banner, widget.visualType));
      }
    });
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Wrap(children: containers),
    );
  }

  _visualType2(context, _banners) {
    List<Container> containers = [];
    _banners.forEach((banner) {
      if (int.parse(banner.status) != 0) {
        containers.add(_getBannerView(context, banner, widget.visualType));
      }
    });

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Wrap(
          spacing: 0, // gap between adjacent chips
          runSpacing: 0, // gap between lines
          children: containers),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getBannerView(context, BannerData banner, visualType) {
    double radius = 5;
    return Container(
      padding: EdgeInsets.all(5),
      width: (MediaQuery.of(context).size.width - (visualType == 1 ? 0 : 10)) /
          (visualType == 1 ? 1 : 2),
      child: GestureDetector(
        onTap: () {
          if (banner.link != "" && banner.link != "/" && banner.link != null) {
            if (banner.link!.split('http').length > 1) {
              _launchURL(banner.link.toString());
            } else {
              Navigator.pushNamed(
                  context, (banner.link != "") ? banner.link! : '/',
                  arguments: RouteSettings(name: banner.title));
            }
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: FadeInImage.assetNetwork(
              fadeInDuration: Duration(milliseconds: 100),
              fadeOutDuration: Duration(milliseconds: 100),
              fit: BoxFit.fill,
              placeholder: visualType == 1
                  ? 'assets/images/banner/homebanner.png'
                  : 'assets/images/banner/homebanner.png',
              image: GeneralCons.imageUrl + banner.filePath!,
            ),
          ),
        ),
      ),
    );
  }
}
