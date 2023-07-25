// To parse this JSON data, do
//
//     final bannerData = bannerDataFromJson(jsonString);

import 'dart:convert';

BannerData bannerDataFromJson(String str) =>
    BannerData.fromJson(json.decode(str));

String bannerDataToJson(BannerData data) => json.encode(data.toJson());

class BannerData {
  String? id;
  String? bannerGroupId;
  String? filePath;
  String? name;
  String? title;
  String? description;
  String? link;
  String? order;
  String? target;
  String? attribute;
  String? gender;
  String? type;
  String? lang;
  String? device;
  String? status;
  String? customVal1;
  String? customVal2;
  DateTime? createdAt;
  DateTime? updatedAt;

  BannerData({
    this.id,
    this.bannerGroupId,
    this.filePath,
    this.name,
    this.title,
    this.description,
    this.link,
    this.order,
    this.target,
    this.attribute,
    this.gender,
    this.type,
    this.lang,
    this.device,
    this.status,
    this.customVal1,
    this.customVal2,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"].toString(),
        bannerGroupId: json["banner_group_id"].toString(),
        filePath: json["file_path"].toString(),
        name: json["name"].toString(),
        title: json["title"].toString(),
        description: json["description"].toString(),
        link: json["link"].toString(),
        order: json["order"].toString(),
        target: json["target"].toString(),
        attribute: json["attribute"].toString(),
        gender: json["gender"].toString(),
        type: json["type"].toString(),
        lang: json["lang"].toString(),
        device: json["device"].toString(),
        status: json["status"].toString(),
        customVal1: json["custom_val1"],
        customVal2: json["custom_val2"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_group_id": bannerGroupId,
        "file_path": filePath,
        "name": name,
        "title": title,
        "description": description,
        "link": link,
        "order": order,
        "target": target,
        "attribute": attribute,
        "gender": gender,
        "type": type,
        "lang": lang,
        "device": device,
        "status": status,
        "custom_val1": customVal1,
        "custom_val2": customVal2,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
