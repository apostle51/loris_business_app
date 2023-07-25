// To parse this JSON data, do
//
//     final productCategoryData = productCategoryDataFromJson(jsonString);

import 'dart:convert';

ProductCategoryData productCategoryDataFromJson(String str) =>
    ProductCategoryData.fromJson(json.decode(str));

String productCategoryDataToJson(ProductCategoryData data) =>
    json.encode(data.toJson());

class ProductCategoryData {
  ProductCategoryData({
    this.id,
    this.title,
    this.parentId,
    this.gender,
    this.totalProduct,
    this.order,
    this.isVisible,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customVal,
    this.children,
    this.productCategoryInfos,
  });

  int? id;
  String? title;
  int? parentId;
  String? gender;
  int? totalProduct;
  int? order;
  int? isVisible;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? customVal;
  List<ProductCategoryData>? children;
  List<ProductCategoryInfo>? productCategoryInfos;

  factory ProductCategoryData.fromJson(Map<String, dynamic> json) =>
      ProductCategoryData(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        gender: json["gender"] == null ? null : json["gender"],
        totalProduct:
            json["total_product"] == null ? null : json["total_product"],
        order: json["order"] == null ? null : json["order"],
        isVisible: json["is_visible"] == null ? null : json["is_visible"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customVal: json["custom_val"] == null ? null : json["custom_val"],
        children: json["children"] == null
            ? null
            : List<ProductCategoryData>.from(
                json["children"].map((x) => ProductCategoryData.fromJson(x))),
        productCategoryInfos: json["product_category_infos"] == null
            ? null
            : List<ProductCategoryInfo>.from(json["product_category_infos"]
                .map((x) => ProductCategoryInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "parent_id": parentId == null ? null : parentId,
        "gender": gender == null ? null : gender,
        "total_product": totalProduct == null ? null : totalProduct,
        "order": order == null ? null : order,
        "is_visible": isVisible == null ? null : isVisible,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "custom_val": customVal == null ? null : customVal,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "product_category_infos": productCategoryInfos == null
            ? null
            : List<dynamic>.from(productCategoryInfos!.map((x) => x.toJson())),
      };
}

class ProductCategoryInfo {
  ProductCategoryInfo({
    this.id,
    this.productCategoryId,
    this.title,
    this.image,
    this.link,
    this.prefixLink,
    this.slogan,
    this.seoTitle,
    this.seoDescription,
    this.seoKeywords,
    this.text,
    this.lang,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? productCategoryId;
  String? title;
  String? image;
  String? link;
  String? prefixLink;
  String? slogan;
  String? seoTitle;
  String? seoDescription;
  String? seoKeywords;
  String? text;
  String? lang;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProductCategoryInfo.fromJson(Map<String, dynamic> json) =>
      ProductCategoryInfo(
        id: json["id"] == null ? null : json["id"],
        productCategoryId: json["product_category_id"] == null
            ? null
            : json["product_category_id"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        link: json["link"] == null ? null : json["link"],
        prefixLink: json["prefix_link"] == null ? null : json["prefix_link"],
        slogan: json["slogan"] == null ? null : json["slogan"],
        seoTitle: json["seo_title"] == null ? null : json["seo_title"],
        seoDescription:
            json["seo_description"] == null ? null : json["seo_description"],
        seoKeywords: json["seo_keywords"] == null ? null : json["seo_keywords"],
        text: json["text"] == null ? null : json["text"],
        lang: json["lang"] == null ? null : json["lang"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_category_id":
            productCategoryId == null ? null : productCategoryId,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "link": link == null ? null : link,
        "prefix_link": prefixLink == null ? null : prefixLink,
        "slogan": slogan == null ? null : slogan,
        "seo_title": seoTitle == null ? null : seoTitle,
        "seo_description": seoDescription == null ? null : seoDescription,
        "seo_keywords": seoKeywords == null ? null : seoKeywords,
        "text": text == null ? null : text,
        "lang": lang == null ? null : lang,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
