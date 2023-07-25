import 'startApiClient.dart';

class StartRepository {
  StartApiClient startApiClient = StartApiClient();
  Future getStart() async {
    var result = await startApiClient.getStart();
    return result;
  }

  Future getEnums() async {
    return await startApiClient.getEnums();
  }

  Future getCountries() async {
    return await startApiClient.getCountries();
  }

  Future getCities(country, search) async {
    return await startApiClient.getCities(country, search);
  }

  Future getDistricts(city, search) async {
    return await startApiClient.getDistricts(city, search);
  }

  Future getNeighbourhood(district) async {
    return await startApiClient.getNeighbourhood(district);
  }

  Future getStreets(neighbourhood) async {
    return await startApiClient.getStreets(neighbourhood);
  }

  // Notification

  Future setTokenOnServer(token) async {
    return await startApiClient.setTokenOnServer(token);
  }

  // Contents
  Future getContent(id) async {
    return await startApiClient.getContent(id);
  }

  Future getContentCategoryinContents(id) async {
    return await startApiClient.getContentCategoryinContents(id);
  }

  // Banner Group
  Future getBannerGroupsByBannerGroupId(id) async {
    return await startApiClient.getBannerGroupsByBannerGroupId(id);
  }
}
