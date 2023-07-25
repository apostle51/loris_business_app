// To parse this JSON data, do
//
//     final contentData = contentDataFromJson(jsonString);

import 'dart:convert';

ContentData contentDataFromJson(String str) =>
    ContentData.fromJson(json.decode(str));

String contentDataToJson(ContentData data) => json.encode(data.toJson());

class ContentData {
  ContentData({
    this.id,
    this.title,
    this.image,
    this.description,
    this.seoTitle,
    this.seoDescription,
    this.link,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.publishDate,
    this.sortOrder,
    this.hit,
    this.like,
    this.ownerId,
    this.lang,
    this.status,
    this.type,
    this.contentCategories,
    this.bannerGroups,
    this.owner,
  });

  int? id;
  String? title;
  String? image;
  String? description;
  String? seoTitle;
  String? seoDescription;
  String? link;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishDate;
  DateTime? sortOrder;
  int? hit;
  int? like;
  int? ownerId;
  String? lang;
  int? status;
  int? type;
  List<dynamic>? contentCategories;
  List<dynamic>? bannerGroups;
  dynamic owner;

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
        seoTitle: json["seo_title"] == null ? null : json["seo_title"],
        seoDescription:
            json["seo_description"] == null ? null : json["seo_description"],
        link: json["link"] == null ? null : json["link"],
        text: json["text"] == null ? null : json["text"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        publishDate: json["publish_date"] == null
            ? null
            : DateTime.parse(json["publish_date"]),
        sortOrder: json["sort_order"] == null
            ? null
            : DateTime.parse(json["sort_order"]),
        hit: json["hit"] == null ? null : json["hit"],
        like: json["like"] == null ? null : json["like"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        lang: json["lang"] == null ? null : json["lang"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        contentCategories: json["content_categories"] == null
            ? null
            : List<dynamic>.from(json["content_categories"].map((x) => x)),
        bannerGroups: json["banner_groups"] == null
            ? null
            : List<dynamic>.from(json["banner_groups"].map((x) => x)),
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "description": description == null ? null : description,
        "seo_title": seoTitle == null ? null : seoTitle,
        "seo_description": seoDescription == null ? null : seoDescription,
        "link": link == null ? null : link,
        "text": text == null ? null : text,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publish_date":
            publishDate == null ? null : publishDate!.toIso8601String(),
        "sort_order": sortOrder == null ? null : sortOrder!.toIso8601String(),
        "hit": hit == null ? null : hit,
        "like": like == null ? null : like,
        "owner_id": ownerId == null ? null : ownerId,
        "lang": lang == null ? null : lang,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "content_categories": contentCategories == null
            ? null
            : List<dynamic>.from(contentCategories!.map((x) => x)),
        "banner_groups": bannerGroups == null
            ? null
            : List<dynamic>.from(bannerGroups!.map((x) => x)),
        "owner": owner,
      };
}
