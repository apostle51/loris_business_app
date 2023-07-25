// To parse this JSON data, do
//
//     final productFeaturesData = productFeaturesDataFromJson(jsonString);

import 'dart:convert';

ProductFeaturesData productFeaturesDataFromJson(String str) =>
    ProductFeaturesData.fromJson(json.decode(str));

String productFeaturesDataToJson(ProductFeaturesData data) =>
    json.encode(data.toJson());

class ProductFeaturesData {
  ProductFeaturesData({
    this.id,
    this.title,
    this.lang,
    this.status,
    this.show,
    this.createdAt,
    this.updatedAt,
    this.productFeatureDetails,
    this.featureId,
  });

  int? id;
  String? title;
  String? lang;
  int? status;
  int? show;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductFeaturesData>? productFeatureDetails;
  int? featureId;

  factory ProductFeaturesData.fromJson(Map<String, dynamic> json) =>
      ProductFeaturesData(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        lang: json["lang"] == null ? null : json["lang"],
        status: json["status"] == null ? null : json["status"],
        show: json["show"] == null ? null : json["show"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productFeatureDetails: json["product_feature_details"] == null
            ? null
            : List<ProductFeaturesData>.from(json["product_feature_details"]
                .map((x) => ProductFeaturesData.fromJson(x))),
        featureId: json["feature_id"] == null ? null : json["feature_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "lang": lang == null ? null : lang,
        "status": status == null ? null : status,
        "show": show == null ? null : show,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "product_feature_details": productFeatureDetails == null
            ? null
            : List<dynamic>.from(productFeatureDetails!.map((x) => x.toJson())),
        "feature_id": featureId == null ? null : featureId,
      };
}
