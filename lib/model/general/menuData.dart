// To parse this JSON data, do
//
//     final menuData = menuDataFromJson(jsonString);

import 'dart:convert';

MenuData menuDataFromJson(String str) => MenuData.fromJson(json.decode(str));

String menuDataToJson(MenuData data) => json.encode(data.toJson());

class MenuData {
  MenuData({
    this.id,
    this.menuGroupId,
    this.title,
    this.linkType,
    this.attributes,
    this.link,
    this.icon,
    this.mobileIcon,
    this.image,
    this.lang,
    this.order,
    this.parentId,
    this.status,
    this.child,
  });

  int? id;
  int? menuGroupId;
  String? title;
  int? linkType;
  String? attributes;
  String? link;
  String? icon;
  String? mobileIcon;
  String? image;
  String? lang;
  int? order;
  int? parentId;
  int? status;
  List<MenuData>? child;

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
        id: json["id"],
        menuGroupId: json["menu_group_id"],
        title: json["title"],
        linkType: json["link_type"],
        attributes: json["attributes"],
        link: json["link"],
        icon: json["icon"],
        mobileIcon: json["mobile_icon"],
        image: json["image"],
        lang: json["lang"],
        order: json["order"],
        parentId: json["parent_id"],
        status: json["status"],
        child: json["child"] != null
            ? List<MenuData>.from(
                json["child"].map((x) => MenuData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menu_group_id": menuGroupId,
        "title": title,
        "link_type": linkType,
        "attributes": attributes,
        "link": link,
        "icon": icon,
        "mobile_icon": mobileIcon,
        "image": image,
        "lang": lang,
        "order": order,
        "parent_id": parentId,
        "status": status,
        "child": List<dynamic>.from(child!.map((x) => x.toJson())),
      };
}
