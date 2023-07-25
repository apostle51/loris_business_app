import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../cons/general.dart';
import '../../controller/startController.dart';
import '/theme/appColors.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _startController = StartController.to;

  _clearData() async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.remove('token');
    //await preferences.remove('tokenData');
  }

  @override
  Widget build(BuildContext context) {
    String phone = _startController.getSettings('company', 'phone');
    String company = _startController.getSettings('general', 'app_name');
    String email = _startController.getSettings('company', 'email');
    String address = _startController.getSettings('company', 'address');
    String city = _startController.getSettings('company', 'city');
    String dist = _startController.getSettings('company', 'district');
    String slogan = _startController.getSettings('general', 'app_slogan');
    // String whatsapp = PublicFunctions.getSettings(
    //     _startViewModel.startData['settings'], 'company', 'whatsapp');
    String footer_desc =
        _startController.getSettings('site_settings', 'footer_desc');
    double statusBarHeight = MediaQuery.of(context).padding.top;

    String pascubeLogo = _startController.getSettings('pascube', 'logo_url');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.1,
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFccc)),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.white, AppColors.grey])),
            child: SizedBox(),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: statusBarHeight + 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/logo/logo.svg",
                            width: 150, semanticsLabel: GeneralCons.appName),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height,
                        child: Material(
                            elevation: 3,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            child: ConstrainedBox(
                                constraints: new BoxConstraints(
                                  minHeight: 300.0,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Text(
                                          footer_desc,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColors.textLight,
                                              height: 1.5,
                                              fontSize: 20),
                                        )),
                                    Container(
                                      decoration:
                                          AppColors.boxDecorationBorderBottom,
                                      child: ListTile(
                                        onTap: () => launch("tel://" + phone),
                                        leading: Icon(
                                          Icons.phone,
                                          size: 30,
                                          color: AppColors.dark,
                                        ),
                                        title: Text(
                                          phone.toString(),
                                          style: AppColors.darkT(
                                              bold: true, size: 15),
                                        ),
                                        subtitle: Text('Çağrı Merkezi'),
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          AppColors.boxDecorationBorderBottom,
                                      child: ListTile(
                                        onTap: () => launch('mailto:' + email),
                                        leading: Icon(
                                          Icons.message,
                                          size: 30,
                                          color: AppColors.dark,
                                        ),
                                        title: Text(
                                          email.toString(),
                                          style: AppColors.darkT(
                                              bold: true, size: 15),
                                        ),
                                        subtitle: Text('7/24 E-Mail'),
                                      ),
                                    ),
                                    // Container(
                                    //   decoration:
                                    //       AppColors.boxDecorationBorderBottom,
                                    //   child: ListTile(
                                    //     onTap: () => launch(
                                    //         'https://api.whatsapp.com/send?phone=' +
                                    //             whatsapp +
                                    //             '&text=Ebijuteri.com'),
                                    //     leading: Icon(
                                    //       Icons.mail,
                                    //       size: 30,
                                    //       color: AppColors.dark,
                                    //     ),
                                    //     title: Text(
                                    //       whatsapp.toString(),
                                    //       style: AppColors.h3Black,
                                    //     ),
                                    //     subtitle: Text('WhatsApp Destek'),
                                    //   ),
                                    // ),
                                    Container(
                                      decoration:
                                          AppColors.boxDecorationBorderBottom,
                                      child: ListTile(
                                        onTap: _clearData,
                                        leading: Icon(
                                          Icons.pin_drop,
                                          size: 30,
                                          color: AppColors.dark,
                                        ),
                                        title: Text(
                                          'Merkez',
                                          style: AppColors.darkT(
                                              bold: true, size: 15),
                                        ),
                                        subtitle: Text(
                                          address + ' ' + dist + ' / ' + city,
                                          style: TextStyle(height: 1.2),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Center(
                                        child: Wrap(
                                          spacing: 20,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    '/contents/' +
                                                        _startController
                                                            .getSettings(
                                                                'mobile_app',
                                                                'user_agreement_content_id'));
                                              },
                                              child: Text(
                                                'Kullanıcı Sözleşmesi',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      '/contents/' +
                                                          _startController
                                                              .getSettings(
                                                                  'mobile_app',
                                                                  'user_privacy_content_id'));
                                                },
                                                child: Text(
                                                    'Gizlilik Sözleşmesi',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline)))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Center(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Urbanist',
                                                color: Colors.black,
                                                height: 1.5),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: company,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Urbanist')),
                                              TextSpan(
                                                  text:
                                                      ' Eticaret ve Mobil Uygulamaları '),
                                              TextSpan(
                                                  text: 'PASCUBE ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text:
                                                      ' tarafından geliştirilmiştir.. '),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => launch(
                                          "https://pascube.com?utm_source=customer&utm_medium=ebijuteri_mobile_app"),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Image.network(pascubeLogo),
                                      ),
                                    )
                                  ],
                                )))),
                  ))
                ],
              ),
            ),
          ),
          Positioned(
            left: 00,
            top: statusBarHeight + 10,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
      ),
    );
  }
}
