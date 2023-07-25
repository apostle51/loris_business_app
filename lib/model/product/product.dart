// To parse this JSON data, do
//
//     final productItemData = productItemDataFromJson(jsonString);

import 'dart:convert';

ProductItemData productItemDataFromJson(String str) =>
    ProductItemData.fromJson(json.decode(str));

String productItemDataToJson(ProductItemData data) =>
    json.encode(data.toJson());

class ProductItemData {
  ProductItemData({
    this.id,
    this.info,
    this.stock,
    this.master,
    this.prices,
    this.serials,
    this.sortDate,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.expertiseReports,
    this.stockToProducts,
    this.campaign,
  });

  String? id;
  Info? info;
  Stock? stock;
  Master? master;
  Prices? prices;
  List<Serial>? serials;
  DateTime? sortDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Image>? images;
  List<dynamic>? expertiseReports;
  List<StockToProduct>? stockToProducts;

  Campaign? campaign;

  factory ProductItemData.fromJson(Map<String, dynamic> json) =>
      ProductItemData(
        id: json["_id"] == null ? null : json["_id"],
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        stock: json["stock"] == null ? null : Stock.fromJson(json["stock"]),
        master: json["master"] == null ? null : Master.fromJson(json["master"]),
        prices: json["prices"] == null ? null : Prices.fromJson(json["prices"]),
        serials: json["serials"] == null
            ? null
            : List<Serial>.from(json["serials"].map((x) => Serial.fromJson(x))),
        sortDate: json["sort_date"] == null
            ? null
            : DateTime.parse(json["sort_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? null
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        expertiseReports: json["expertise_reports"] == null
            ? null
            : List<dynamic>.from(json["expertise_reports"].map((x) => x)),
        campaign: json["campaign"] == null
            ? null
            : Campaign.fromJson(json["campaign"]),
        stockToProducts: json["stock_to_products"] == null
            ? null
            : List<StockToProduct>.from(json["stock_to_products"]
                .map((x) => StockToProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "info": info == null ? null : info!.toJson(),
        "stock": stock == null ? null : stock!.toJson(),
        "master": master == null ? null : master!.toJson(),
        "prices": prices == null ? null : prices!.toJson(),
        "serials": serials == null
            ? null
            : List<dynamic>.from(serials!.map((x) => x.toJson())),
        "sort_date": sortDate == null ? null : sortDate!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "expertise_reports": expertiseReports == null
            ? null
            : List<dynamic>.from(expertiseReports!.map((x) => x)),
        "stock_to_products": stockToProducts == null
            ? null
            : List<dynamic>.from(stockToProducts!.map((x) => x.toJson())),
        "campaign": campaign == null ? null : campaign!.toJson(),
      };
}

class Image {
  Image({
    this.path,
    this.order,
  });

  String? path;
  int? order;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json["path"] == null ? null : json["path"],
        order:
            json["order"] == null ? null : int.parse(json["order"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "path": path == null ? null : path,
        "order": order == null ? null : order,
      };
}

class Info {
  Info({
    this.detail,
    this.sameBrand,
    this.title,
    this.seoTitle,
    this.seoDesc,
    this.brand,
    this.masterCategory,
    this.shortDetail,
    this.gender,
    this.categories,
    this.features,
    this.productUnitDesc,
    this.productUnit,
  });
  SameBrand? sameBrand;
  String? detail;
  String? title;
  String? seoTitle;
  String? seoDesc;
  String? productUnitDesc;
  Brand? brand;
  MasterCategory? masterCategory;
  String? shortDetail;
  int? gender;
  int? productUnit;
  List<Category>? categories;
  List<Feature>? features;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        detail: json["detail"] == null ? null : json["detail"],
        sameBrand: json["same_brand"] == null
            ? null
            : SameBrand.fromJson(json["same_brand"]),
        productUnitDesc: json["product_unit_desc"] == null
            ? null
            : json["product_unit_desc"],
        productUnit: json["product_unit"] == null
            ? 0
            : int.parse(json["product_unit"].toString()),
        seoTitle: json["seo_title"] == null ? null : json["seo_title"],
        title: json["title"] == null ? null : json["title"],
        seoDesc: json["seo_desc"] == null ? null : json["seo_desc"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        masterCategory: json["masterCategory"] == null
            ? null
            : MasterCategory.fromJson(json["masterCategory"]),
        shortDetail: json["shortDetail"] == null ? null : json["shortDetail"],
        gender: json["gender"] == null
            ? null
            : int.parse(json["gender"].toString()),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        features: json["features"] == null
            ? null
            : List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail == null ? null : detail,
        "same_brand": sameBrand == null ? null : sameBrand!.toJson(),
        "title": title == null ? null : title,
        "product_unit_desc": productUnitDesc == null ? null : productUnitDesc,
        "product_unit": productUnit == null ? null : productUnit,
        "seo_title": seoTitle == null ? null : seoTitle,
        "seo_desc": seoDesc == null ? null : seoDesc,
        "brand": brand == null ? null : brand!.toJson(),
        "masterCategory":
            masterCategory == null ? null : masterCategory!.toJson(),
        "shortDetail": shortDetail == null ? null : shortDetail,
        "gender": gender == null ? null : gender,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "features": features == null
            ? null
            : List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class SameBrand {
  SameBrand({
    this.refBrand,
    this.refBrandDetail,
  });

  String? refBrand;
  String? refBrandDetail;

  factory SameBrand.fromJson(Map<String, dynamic> json) => SameBrand(
        refBrand: json["refBrand"] == null ? null : json["refBrand"],
        refBrandDetail:
            json["refBrandDetail"] == null ? null : json["refBrandDetail"],
      );

  Map<String, dynamic> toJson() => {
        "refBrand": refBrand == null ? null : refBrand,
        "refBrandDetail": refBrandDetail == null ? null : refBrandDetail,
      };
}

class Brand {
  Brand({
    this.id,
    this.brandName,
  });

  int? id;
  String? brandName;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        brandName: json["brand_name"] == null ? null : json["brand_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "brand_name": brandName == null ? null : brandName,
      };
}

class Category {
  Category({
    this.id,
  });

  String? id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
      };
}

class Feature {
  Feature({
    this.id,
    this.detailIds,
  });

  String? id;
  List<int>? detailIds;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] == null || json["id"].length == 0
            ? null
            : json["id"].length > 0
                ? json["id"][0]
                : json["id"],
        detailIds: json["detailIds"] == null
            ? null
            : List<int>.from(
                json["detailIds"].map((x) => int.parse(x.toString()))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "detailIds": detailIds == null
            ? null
            : List<dynamic>.from(detailIds!.map((x) => x)),
      };
}

class MasterCategory {
  MasterCategory({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory MasterCategory.fromJson(Map<String, dynamic> json) => MasterCategory(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
      };
}

class Master {
  Master({
    this.label,
    this.xmlShowStatus,
    this.status,
    this.stockStatus,
    this.justCredit,
    this.link,
    this.tax,
  });

  Label? label;
  String? xmlShowStatus;
  String? status;
  String? stockStatus;
  String? justCredit;
  String? link;
  double? tax;

  factory Master.fromJson(Map<String, dynamic> json) => Master(
        label: json["label"] == null ? null : Label.fromJson(json["label"]),
        xmlShowStatus: json["xmlShowStatus"] == null
            ? null
            : json["xmlShowStatus"].toString(),
        status: json["status"] == null ? null : json["status"].toString(),
        stockStatus: json["stock_status"] == null
            ? null
            : json["stock_status"].toString(),
        justCredit: json["just_credit"] == null ? null : json["just_credit"],
        link: json["link"] == null ? null : json["link"],
        tax: json["tax"] == null ? null : double.parse(json["tax"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "label": label == null ? null : label!.toJson(),
        "xmlShowStatus": xmlShowStatus == null ? null : xmlShowStatus,
        "status": status == null ? null : status,
        "stock_status": stockStatus == null ? null : stockStatus,
        "just_credit": justCredit == null ? null : justCredit,
        "link": link == null ? null : link,
        "tax": tax == null ? null : tax,
      };
}

class Label {
  Label({
    this.freeShipping,
    this.isNew,
    this.isSale,
    this.isShowcase,
  });

  String? freeShipping;
  String? isNew;
  String? isSale;
  String? isShowcase;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        freeShipping: json["freeShipping"] == null
            ? null
            : json["freeShipping"].toString(),
        isNew: json["isNew"] == null ? null : json["isNew"].toString(),
        isSale: json["isSale"] == null ? null : json["isSale"].toString(),
        isShowcase:
            json["isShowcase"] == null ? null : json["isShowcase"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "freeShipping": freeShipping == null ? null : freeShipping,
        "isNew": isNew == null ? null : isNew,
        "isSale": isSale == null ? null : isSale,
        "isShowcase": isShowcase == null ? null : isShowcase,
      };
}

class Prices {
  Prices({
    this.currency,
    this.all,
    this.alisFiyati,
    this.satisFiyati,
    this.piyasaFiyati,
  });

  String? currency;
  Map<String, double>? all;
  double? alisFiyati;
  double? satisFiyati;
  double? piyasaFiyati;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        currency: json["currency"] == null ? null : json["currency"],
        all: json["all"] == null || json["all"].length == 0
            ? null
            : Map.from(json["all"]).map((k, v) => MapEntry<String, double>(
                k, double.parse(v != null ? v.toString() : "0"))),
        alisFiyati: json["alisFiyati"] == null
            ? null
            : double.parse(json["alisFiyati"].toString()),
        satisFiyati: json["satisFiyati"] == null
            ? null
            : double.parse(json["satisFiyati"].toString()),
        piyasaFiyati: json["piyasaFiyati"] == null
            ? null
            : double.parse(json["piyasaFiyati"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "currency": currency == null ? null : currency,
        "all": all == null
            ? null
            : Map.from(all!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "alisFiyati": alisFiyati == null ? null : alisFiyati,
        "satisFiyati": satisFiyati == null ? null : satisFiyati,
        "piyasaFiyati": piyasaFiyati == null ? null : piyasaFiyati,
      };
}

class Serial {
  Serial({
    this.id,
    this.key,
    this.serialType,
    this.title,
    this.titleLink,
    this.serialCode,
    this.defaultList,
    this.isNew,
    this.isSale,
    this.minOrderQuantity,
    this.maxOrderQuantity,
    this.realQuantity,
    this.justCredit,
    this.status,
    this.updatedate,
    this.freeShipping,
    this.tempStock,
  });

  String? id;
  String? key;
  dynamic? serialType;
  String? title;
  dynamic? titleLink;
  String? serialCode;
  int? defaultList;
  String? isNew;
  String? isSale;
  String? minOrderQuantity;
  String? maxOrderQuantity;
  String? realQuantity;
  String? justCredit;
  int? status;
  DateTime? updatedate;
  String? freeShipping;
  TempStock? tempStock;

  factory Serial.fromJson(Map<String, dynamic> json) => Serial(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        serialType: json["serial_type"],
        title: json["title"] == null ? null : json["title"],
        titleLink: json["title_link"],
        serialCode: json["serial_code"] == null ? null : json["serial_code"],
        defaultList: json["default_list"] == null ? null : json["default_list"],
        isNew: json["isNew"] == null ? null : json["isNew"],
        isSale: json["isSale"] == null ? null : json["isSale"],
        minOrderQuantity: json["min_order_quantity"] == null
            ? null
            : json["min_order_quantity"],
        maxOrderQuantity: json["max_order_quantity"] == null
            ? null
            : json["max_order_quantity"],
        realQuantity: json["real_quantity"] == null
            ? null
            : json["real_quantity"].toString(),
        justCredit: json["just_credit"] == null ? null : json["just_credit"],
        status: json["status"] == null ? null : json["status"],
        updatedate: json["updatedate"] == null
            ? null
            : DateTime.parse(json["updatedate"]),
        freeShipping:
            json["freeShipping"] == null ? null : json["freeShipping"],
        tempStock: json["temp_stock"] == null
            ? null
            : TempStock.fromJson(json["temp_stock"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "serial_type": serialType,
        "title": title == null ? null : title,
        "title_link": titleLink,
        "serial_code": serialCode == null ? null : serialCode,
        "default_list": defaultList == null ? null : defaultList,
        "isNew": isNew == null ? null : isNew,
        "isSale": isSale == null ? null : isSale,
        "min_order_quantity":
            minOrderQuantity == null ? null : minOrderQuantity,
        "max_order_quantity":
            maxOrderQuantity == null ? null : maxOrderQuantity,
        "real_quantity": realQuantity == null ? null : realQuantity,
        "just_credit": justCredit == null ? null : justCredit,
        "status": status == null ? null : status,
        "updatedate": updatedate == null ? null : updatedate!.toIso8601String(),
        "freeShipping": freeShipping == null ? null : freeShipping,
        "temp_stock": tempStock == null ? null : tempStock!.toJson(),
      };
}

class TempStock {
  TempStock({
    this.totalInStock,
    this.totalInOrder,
    this.totalSaled,
    this.totalStock,
  });

  int? totalInStock;
  int? totalInOrder;
  int? totalSaled;
  int? totalStock;

  factory TempStock.fromJson(Map<String, dynamic> json) => TempStock(
        totalInStock:
            json["total_in_stock"] == null ? null : json["total_in_stock"],
        totalInOrder:
            json["total_in_order"] == null ? null : json["total_in_order"],
        totalSaled: json["total_saled"] == null ? null : json["total_saled"],
        totalStock: json["total_stock"] == null ? null : json["total_stock"],
      );

  Map<String, dynamic> toJson() => {
        "total_in_stock": totalInStock == null ? null : totalInStock,
        "total_in_order": totalInOrder == null ? null : totalInOrder,
        "total_saled": totalSaled == null ? null : totalSaled,
        "total_stock": totalStock == null ? null : totalStock,
      };
}

class Stock {
  Stock({
    this.dimensions,
    this.minOrderQuantity,
    this.maxOrderQuantity,
    this.realQuantity,
    this.productCode,
    this.productStockName,
    this.totalTempStock,
  });

  Dimensions? dimensions;
  String? minOrderQuantity;
  String? maxOrderQuantity;
  String? realQuantity;
  String? productCode;
  String? productStockName;
  TempStock? totalTempStock;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        minOrderQuantity: json["min_order_quantity"] == null
            ? null
            : json["min_order_quantity"],
        maxOrderQuantity: json["max_order_quantity"] == null
            ? null
            : json["max_order_quantity"],
        realQuantity: json["real_quantity"] == null
            ? null
            : json["real_quantity"].toString(),
        productCode: json["product_code"] == null ? null : json["product_code"],
        productStockName: json["product_stock_name"] == null
            ? null
            : json["product_stock_name"],
        totalTempStock: json["total_temp_stock"] == null
            ? null
            : TempStock.fromJson(json["total_temp_stock"]),
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions == null ? null : dimensions!.toJson(),
        "min_order_quantity":
            minOrderQuantity == null ? null : minOrderQuantity,
        "max_order_quantity":
            maxOrderQuantity == null ? null : maxOrderQuantity,
        "real_quantity": realQuantity == null ? null : realQuantity,
        "product_code": productCode == null ? null : productCode,
        "product_stock_name":
            productStockName == null ? null : productStockName,
        "total_temp_stock":
            totalTempStock == null ? null : totalTempStock!.toJson(),
      };
}

class Campaign {
  Campaign({
    this.oldPrice,
    this.campaignPrice,
    this.endDate,
    this.title,
  });

  double? oldPrice;
  String? campaignPrice;
  DateTime? endDate;
  String? title;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        oldPrice: json["old_price"] == null
            ? null
            : double.parse(json["old_price"].toString()),
        campaignPrice: json["campaign_price"] == null
            ? null
            : json["campaign_price"].toString(),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "old_price": oldPrice == null ? null : oldPrice,
        "campaign_price": campaignPrice == null ? null : campaignPrice,
        "end_date": endDate == null ? null : endDate!.toIso8601String(),
        "title": title == null ? null : title,
      };
}

class Dimensions {
  Dimensions({
    this.dimensionsX,
    this.dimensionsY,
    this.dimensionsZ,
  });

  String? dimensionsX;
  String? dimensionsY;
  String? dimensionsZ;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        dimensionsX: json["dimensions_x"] == null
            ? null
            : json["dimensions_x"].toString(),
        dimensionsY: json["dimensions_y"] == null
            ? null
            : json["dimensions_y"].toString(),
        dimensionsZ: json["dimensions_z"] == null
            ? null
            : json["dimensions_z"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "dimensions_x": dimensionsX == null ? null : dimensionsX,
        "dimensions_y": dimensionsY == null ? null : dimensionsY,
        "dimensions_z": dimensionsZ == null ? null : dimensionsZ,
      };
}

class StockToProduct {
  StockToProduct({
    this.id,
    this.productId,
    this.productSerialId,
    this.productVariantId,
    this.totalInStock,
    this.totalInOrder,
    this.totalInBasket,
    this.totalSaled,
  });

  int? id;
  String? productId;
  String? productSerialId;
  String? productVariantId;
  int? totalInStock;
  int? totalInOrder;
  int? totalInBasket;
  int? totalSaled;

  factory StockToProduct.fromJson(Map<String, dynamic> json) => StockToProduct(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        productSerialId: json["product_serial_id"] == null
            ? null
            : json["product_serial_id"],
        productVariantId: json["product_variant_id"] == null
            ? null
            : json["product_variant_id"],
        totalInStock:
            json["total_in_stock"] == null ? null : json["total_in_stock"],
        totalInOrder:
            json["total_in_order"] == null ? null : json["total_in_order"],
        totalInBasket:
            json["total_in_basket"] == null ? null : json["total_in_basket"],
        totalSaled: json["total_saled"] == null ? null : json["total_saled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "product_serial_id": productSerialId == null ? null : productSerialId,
        "product_variant_id":
            productVariantId == null ? null : productVariantId,
        "total_in_stock": totalInStock == null ? null : totalInStock,
        "total_in_order": totalInOrder == null ? null : totalInOrder,
        "total_in_basket": totalInBasket == null ? null : totalInBasket,
        "total_saled": totalSaled == null ? null : totalSaled,
      };
}

class Warehouse {
  Warehouse({
    this.id,
    this.placeCode,
    this.secondaryWarehouses,
  });

  int? id;
  String? placeCode;
  List<dynamic>? secondaryWarehouses;

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        id: json["id"] == null ? null : json["id"],
        placeCode: json["place_code"] == null ? null : json["place_code"],
        secondaryWarehouses: json["secondary_warehouses"] == null
            ? null
            : List<dynamic>.from(json["secondary_warehouses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "place_code": placeCode == null ? null : placeCode,
        "secondary_warehouses": secondaryWarehouses == null
            ? null
            : List<dynamic>.from(secondaryWarehouses!.map((x) => x)),
      };
}
