import 'package:get/get.dart';

import '../data/product/product_repository.dart';
import '../model/product/product.dart';
import '../model/product/productCategory.dart';
import '../model/product/productFeaturesData.dart';
import '../model/product/showcase.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.find<ProductController>();

  ProductRepository _repository = ProductRepository();

  var isLoading = true.obs;
  var isListLoading = true.obs;
  var isFavoritesButtonLoader = false.obs;
  var categoryData = ProductCategoryData().obs;
  var isListLoadMoreLoading = false.obs;
  setIsListLoading(val) => isListLoading(val);

  var catIds = [].obs;
  var featureList = <ProductFeaturesData>[].obs;
  var featureListAll = <ProductFeaturesData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  //////////Categories Area//////////
  var categories;

  Future getCategoryInfoByLink(link, length,
      {sortQuery, specialRequest}) async {
    isListLoading(true);
    try {
      //stateList = ProductListState.StateLoading;
      var query = '';

      if (link != null && link != "yeni-gelenler") {
        categories = await _repository.getCategoryInfoByLink(link);
        if (categories != null && categories.length > 0) {
          getCatIdsFromCategoryData(categories);
          categoryData(ProductCategoryData.fromJson(categories[0]));

          query = "f_m_info-categories-id=";
          query = query + catIds.value.join('|');
        }
      } else if (link != null && link == "yeni-gelenler") {
        catIds([]);
        var data = {
          "title": "Yeni Gelenler",
          "children": [],
          "product_category_infos": [
            {
              "title": "Yeni Gelenler",
              "slogan": null,
              "seo_title": "Yeni Gelenler",
              "text": "Yeni Gelenler",
            }
          ]
        };

        categoryData(ProductCategoryData.fromJson(data));
        // await analyticsCurrentScreen(className: "Category", name: link);
        // await analyticsLog(name: 'Kategori', params: {'link': link});
      } else if (link == null) {
        var data;
        if (specialRequest) {
          data = {
            "title": "Koku Testi Sonuçları",
            "children": [],
            "product_category_infos": [
              {
                "title": "Koku Testi Sonuçları",
                "slogan": null,
                "seo_title": "Koku Testi Sonuçları",
                "text": "Koku Testinde Size Özel Koku Önerilerimiz",
              }
            ]
          };
        } else {
          data = {
            "title": "Arama Sonuçları",
            "children": [],
            "product_category_infos": [
              {
                "title": "Arama Sonuçları",
                "slogan": null,
                "seo_title": "Arama Sonuçları",
                "text": "Arama Sonuçları",
              }
            ]
          };
        }
        categoryData(ProductCategoryData.fromJson(data));
        //await analyticsCurrentScreen(className: "Search", name: "");
      }

      query += sortQuery;
      query += "&length=" + length.toString() + "&page=1";

      var result = await getProductListMain(query);

      isListLoading(false);
      return result;
    } finally {
      isListLoading(false);
    }
  }

  getCatIdsFromCategoryData(catData) {
    catIds([]);
    if (catData != null && catData.length > 0) {
      catIds([catData[0]['id']]);

      if (catData[0]['children'].length > 0) {
        var list = [];
        catData[0]['children'].forEach((child) {
          list.add(child['id']);
          if (child['children'].length > 0) {
            child['children'].forEach((inChild) {
              list.add(inChild['id']);
              if (inChild['children'].length > 0) {
                inChild['children'].forEach((inInChild) {
                  list.add(inInChild['id']);
                });
              }
            });
          }
        });
        catIds(list);
      }
    }

    return catIds.value;
  }

  Future getProductListMain(query) async {
    try {
      var result = await _repository.getProductListMain(query);

      return result;
    } catch (e) {}
  }

  Future getProductFeatures(id) async {
    try {
      var result = await _repository.getProductFeatures(id);
      if (result != null) {
        Iterable tempList = result;
        var list = tempList
            .map((model) =>
                ProductFeaturesData.fromJson(model['product_feature']))
            .toList();
        featureList(list);

        return featureList;
      } else {}
    } catch (e) {
    } finally {}
  }

  Future getProductFeaturesAll(id) async {
    try {
      var result = await _repository.getProductFeatures(id);
      if (result != null) {
        Iterable tempList = result;
        var list = tempList
            .map((model) => ProductFeaturesData.fromJson(model))
            .toList();
        featureListAll(list);

        return featureListAll;
      } else {}
    } catch (e) {
    } finally {}
  }

  Future searchProduct(query) async {
    try {
      isListLoading(true);
      var result = await _repository.searchProduct(query);
      isListLoading(false);
      return result;
    } catch (e) {
      isListLoading(false);
    } finally {
      isListLoading(false);
    }
  }

  Future getRecommended(_getRequestRecomendedBody) async {
    try {
      var result = await _repository.getRecommended(_getRequestRecomendedBody);
      if (result != null) {
        return result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future getLoadMore(query) async {
    try {
      isListLoadMoreLoading(true);

      var result = await _repository.getProductListMain(query);
      isListLoadMoreLoading(false);
      return result;
    } catch (e) {
      isListLoadMoreLoading(false);
    } finally {
      isListLoadMoreLoading(false);
    }
  }
  //////////Categories Area//////////

  //////////Product Area//////////
  Future<ProductItemData> getProduct(id, {product}) async {
    ProductItemData _product = ProductItemData();
    isLoading(true);

    try {
      var result;
      if (product != null) result = product;
      if (id != null) result = await _repository.getProduct(id);
      _product = ProductItemData.fromJson(result);
      isLoading(false);
      return _product;
    } finally {
      isLoading(false);
    }
  }

  Future<ProductItemData> getProductWithLink(link) async {
    ProductItemData _product = ProductItemData();
    isLoading(true);

    try {
      var result;
      result = await _repository.getProductWithLink(link);
      if (result != null) _product = ProductItemData.fromJson(result);
      isLoading(false);
      return _product;
    } finally {
      isLoading(false);
    }
  }

  Future getProductsByIds(ids) async {
    try {
      isListLoading(true);

      var result = await _repository.getProductsByIds(ids);

      isListLoading(false);
      return result;
    } catch (e) {
      isListLoading(false);
    }
  }

  // ShowCase
  var isLoadingShowCase = true.obs;
  final showCase = ShowCaseData().obs;
  var showCaseProducts = [].obs;

  Future getShowCase(id) async {
    try {
      isLoadingShowCase(true);
      if (showCase.value.id == null) {
        var result = await _repository.getShowCase(id);
        showCase(ShowCaseData.fromJson(result['showcase']));
        showCaseProducts(result['products']);
      }
      isLoadingShowCase(false);
    } catch (e) {
    } finally {
      isLoadingShowCase(false);
    }
  }

  var showCases = [].obs;
  Future getShowCases(ids) async {
    try {
      isLoadingShowCase(true);
      if (showCases.length == 0) {
        var result = await _repository.getShowCases(ids);
        showCases(result);
      }
      isLoadingShowCase(false);
    } catch (e) {
    } finally {
      isLoadingShowCase(false);
    }
  }
}
