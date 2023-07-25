import 'product_api_client.dart';

class ProductRepository {
  ProductApiClient productApiClient = ProductApiClient();
  // Product
  Future getProduct(id) async {
    var result = await productApiClient.getProduct(id);
    return result;
  }

  Future getProductWithLink(link) async {
    var result = await productApiClient.getProductWithLink(link);
    return result;
  }

  Future getProductListMain(query) async {
    var result = await productApiClient.getProductListMain(query);
    return result;
  }

  Future searchProduct(query) async {
    var result = await productApiClient.searchProduct(query);
    return result;
  }

  Future getRecommended(_getRequestRecomendedBody) async {
    var result =
        await productApiClient.getRecommended(_getRequestRecomendedBody);
    return result;
  }

  Future getProductsByIds(ids) async {
    var result = await productApiClient.getProductsByIds(ids);
    return result;
  }

  Future addtoFavoriteToServer(payload) async {
    var result = await productApiClient.addtoFavoriteToServer(payload);
    return result;
  }

  Future removeFavoriteToServer(payload) async {
    var result = await productApiClient.removeFavoriteToServer(payload);
    return result;
  }

  //ShowCase
  Future getShowCase(id) async {
    var result = await productApiClient.getShowCase(id);
    return result;
  }

  Future getShowCases(ids) async {
    var result = await productApiClient.getShowCases(ids);
    return result;
  }

  //Category
  Future getCategoryInfoByLink(link) async {
    var result = await productApiClient.getCategoryInfoByLink(link);
    return result;
  }

  Future getProductFeatures(id) async {
    var result = await productApiClient.getProductFeatures(id);
    return result;
  }
}
