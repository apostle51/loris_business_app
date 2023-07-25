import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../cons/general.dart';

class ProductApiClient {
  final http.Client httpClient = http.Client();

  // Product
  Future getProduct(id) async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal + 'api/products/' + id);
    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body);
  }

  Future getProductWithLink(link) async {
    Uri endPoint =
        Uri.parse(GeneralCons.apiUrlFinal + 'api/products/link/' + link);
    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getProductListMain(query) async {
    Uri endPoint =
        Uri.parse(GeneralCons.apiUrlFinal + 'api/site/product-list?' + query);

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body);
  }

  Future getRecommended(_getRequestRecomendedBody) async {
    try {
      String id = _getRequestRecomendedBody['settings']['exclude'].toString();

      String endPoints = GeneralCons.apiUrlFinal +
          'api/products/recommended/' +
          (id != null ? id : '');

      Uri endPoint = Uri.parse(endPoints);

      var response;
      var body = jsonEncode(_getRequestRecomendedBody);
      response = await http.post(endPoint,
          headers: GeneralCons.sendheaders, body: body);
      if (response.statusCode != 200) {
        throw Exception('Sunucuya Bağlanılamadı');
      }
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future searchProduct(query) async {
    String endPoints =
        GeneralCons.apiUrlFinal + 'api/product-categories/product-list';
    endPoints +=
        "?draw=2&columns%5B0%5D%5Bdata%5D=images&columns%5B1%5D%5Bdata%5D=info.title&columns%5B2%5D%5Bdata%5D=info.same_brand.refBrand&columns%5B3%5D%5Bdata%5D=info.same_brand.refBrandDetail&columns%5B4%5D%5Bdata%5D=info.seo_title&columns%5B5%5D%5Bdata%5D=stock.product_code&start=0&length=30&search%5Bvalue%5D=" +
            query;
    Uri endPoint = Uri.parse(endPoints);
    final response =
        await http.post(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body);
  }

  Future getProductFeatures(id) async {
    Uri endPoint;
    if (id != null) {
      endPoint = Uri.parse(GeneralCons.apiUrlFinal +
          'api/product-categories-to-features?categories=' +
          id.toString());
    } else {
      endPoint = Uri.parse(GeneralCons.apiUrlFinal + '/api/product-features');
    }
    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);
    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  // AdToRelation(favoriteProduct)

  Future addtoFavoriteToServer(payload) async {
    Uri endPoint = Uri.parse(
        GeneralCons.apiUrlFinal + 'api/bp-relation-products/favorites');
    Map<String, String> headers = GeneralCons.sendheaders;
    var response;
    var body = jsonEncode(payload);
    response = await http.post(endPoint, headers: headers, body: body);
    return jsonDecode(response.body)['data'];
  }

  Future removeFavoriteToServer(payload) async {
    Uri endPoint =
        Uri.parse(GeneralCons.apiUrlFinal + 'api/bp-relation-products/remove');
    Map<String, String> headers = GeneralCons.sendheaders;
    var response;
    var body = jsonEncode(payload);
    response = await http.post(endPoint, headers: headers, body: body);
    return jsonDecode(response.body);
  }

  // ShowCase
  Future getShowCase(id) async {
    if (id != null) {
      Uri endPoint = Uri.parse(
          GeneralCons.apiUrlFinal + 'api/showcases/products/' + id.toString());

      final response =
          await http.get(endPoint, headers: GeneralCons.sendheaders);

      if (response.statusCode != 200) {
        throw Exception('Sunucuya Bağlanılamadı');
      }
      return jsonDecode(response.body)['data'];
    }
  }

  Future getShowCases(ids) async {
    if (ids != null) {
      Uri endPoint = Uri.parse(
          GeneralCons.apiUrlFinal + 'api/showcases?ids=' + ids.toString());

      final response =
          await http.get(endPoint, headers: GeneralCons.sendheaders);

      if (response.statusCode != 200) {
        throw Exception('Sunucuya Bağlanılamadı');
      }
      return jsonDecode(response.body)['data'];
    }
  }

  // Category

  Future getCategoryInfoByLink(link) async {
    if (link[0] == "/") {
      link = link.substring(1);
    }
    link = link.split("_")[0];
    Uri endPoint = Uri.parse(
        GeneralCons.apiUrlFinal + 'api/product-categories?link=/' + link);

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);
    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getProductsByIds(ids) async {
    Uri endPoint =
        Uri.parse(GeneralCons.apiUrlFinal + 'api/products/get-multiple');
    Map<String, String> headers = GeneralCons.sendheaders;
    var response;
    List<String> list = ids;
    var body = jsonEncode({"ids": list});

    response = await http.post(endPoint, headers: headers, body: body);

    return jsonDecode(response.body)['data'];
  }
}
