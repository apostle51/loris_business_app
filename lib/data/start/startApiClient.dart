import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../cons/general.dart';

class StartApiClient {
  final http.Client httpClient = http.Client();
  Future getStart() async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal + 'api/mobile/start');
    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);
    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body);
  }

  Future getEnums() async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal + 'api/enums');

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getCountries() async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal + 'api/countries');

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getCities(country, search) async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal +
        'api/cities?country_id=' +
        country.toString());
    if (search != null) {
      endPoint = Uri.parse(
          GeneralCons.apiUrlFinal + 'site/cities/search/' + search.toString());
    }
    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);
    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getDistricts(city, search) async {
    Uri endPoint = Uri.parse(
        GeneralCons.apiUrlFinal + 'api/districts?city_id=' + city.toString());
    if (search != null) {
      endPoint = Uri.parse(GeneralCons.apiUrlFinal +
          'site/districts/search/' +
          search.toString());
    }
    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getNeighbourhood(district) async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal +
        'api/site/neighbourhoods?district_id=' +
        district.toString());

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getStreets(neighbourhood) async {
    Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal +
        'api/site/streets?neighbourhood_id=' +
        neighbourhood.toString());

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  // Notification

  Future setTokenOnServer(token) async {
    Uri endPoint = Uri.parse(
        GeneralCons.apiUrlFinal + 'api/user-notification-subscribers');
    Map<String, String> headers = GeneralCons.sendheaders;
    var response;

    response =
        await http.post(endPoint, headers: headers, body: json.encode(token));

    return jsonDecode(response.body)['data'];
  }

  // Contents

  Future getContent(id) async {
    Uri endPoint =
        Uri.parse(GeneralCons.apiUrlFinal + 'api/contents/' + id.toString());

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getContentCategoryinContents(id) async {
    Uri endPoint = Uri.parse(
        GeneralCons.apiUrlFinal + 'api/content-categories/$id/contents');

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  Future getBannerGroupsByBannerGroupId(id) async {
    var endPointStr = GeneralCons.apiUrlFinal +
        '/api/banner-groups/' +
        id.toString() +
        '/banners';

    Uri endPoint = Uri.parse(endPointStr);

    final response = await http.get(endPoint, headers: GeneralCons.sendheaders);

    if (response.statusCode != 200) {
      throw Exception('Sunucuya Bağlanılamadı');
    }
    return jsonDecode(response.body)['data'];
  }

  //Facebook Api

  Future senFacebook(data) async {
    try {
      Uri endPoint = Uri.parse(GeneralCons.apiUrlFinal + "api/fb/event");
      Map<String, String> headers = GeneralCons.sendheaders;
      var response;
      var body = data;

      response =
          await http.post(endPoint, headers: headers, body: json.encode(body));

      return response;
    } catch (e) {
      print(e);
    }
  }
}
