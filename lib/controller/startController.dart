import 'package:get/get.dart';

import '../data/start/startRepository.dart';
import '../model/contents/contentsData.dart';
import '../services/generalService.dart';

class StartController extends GetxController {
  static StartController get to => Get.find<StartController>();

  StartRepository repository = StartRepository();
  final GeneralService _generalService = GeneralService();

  var isFirstLoading = true.obs;
  var isLoading = true.obs;
  var isInnerLoading = true.obs;
  var startData = {}.obs;
  var loginType = "phone".obs;
  var selectedMenuIndex = 0.obs;
  var selectedTabIndex = 0.obs;
  var firstMessage = true.obs;

  var enumList = [].obs;
  var sliderList = [].obs;
  var homeBanners = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  setSelectedMenuIndex(val) => selectedMenuIndex(val);
  setSelectedTabIndex(val) => selectedTabIndex(val);

  Future initStart(context) async {
    isFirstLoading(true);
    try {
      //Local Product Data

      await getEnums();
      var result = await repository.getStart();
      if (result != null) {
        startData(result);

        String sliderGroupId =
            getSettings('business_app', 'home_slider_group_id');
        String homeBannersid =
            getSettings('business_app', 'home_banner_group_id');

        var res = await getBannerGroupsByBannerGroupId(sliderGroupId);
        if (res != null && res.length > 0) {
          sliderList(res);
        }
        var res2 = await getBannerGroupsByBannerGroupId(homeBannersid);
        if (res2 != null && res2.length > 0) {
          homeBanners(res2);
        }
      }

      await getDeviceId();

      isFirstLoading(false);
    } finally {
      isFirstLoading(false);
    }
  }

  getSettings(group, key) {
    var result;
    startData['settings'].forEach((element) {
      if (element['group'] == group && element['key'] == key) {
        result = element['value'].toString();
      }
    });
    return result;
  }

  // General //

  var deviceID = 'deviceId'.obs;

  Future getDeviceId() async {
    var result = await _generalService.getDeviceID();
    deviceID(result);
  }

  Future getEnums() async {
    isInnerLoading(true);
    try {
      var result = await repository.getEnums();
      enumList(result);
    } catch (e) {
    } finally {
      isInnerLoading(false);
    }
  }

  Future getCountries() async {
    isInnerLoading(true);
    try {
      var result = await repository.getCountries();
      isInnerLoading(false);
      return result;
    } catch (e) {
    } finally {
      isInnerLoading(false);
    }
  }

  Future getCities(country, {search}) async {
    try {
      var result = await repository.getCities(country, search);

      return result;
    } catch (e) {}
  }

  Future getDistricts(city, {search}) async {
    try {
      var result = await repository.getDistricts(city, search);

      return result;
    } catch (e) {}
  }

  Future<ContentData> getContent(id) async {
    isInnerLoading(true);
    try {
      ContentData content = ContentData();
      var result = await repository.getContent(id);
      content = ContentData.fromJson(result);
      isInnerLoading(false);
      return content;
    } catch (e) {
      isInnerLoading(false);
      return ContentData();
    } finally {
      isInnerLoading(false);
    }
  }

  Future getContentCategoryinContents(id) async {
    isInnerLoading(true);
    try {
      var result = await repository.getContentCategoryinContents(id);

      isInnerLoading(false);
      return result;
    } catch (e) {
      isInnerLoading(false);
    }
  }

  var kokuTestiBanners = [].obs;

  Future getBannerGroupsByBannerGroupId(id) async {
    try {
      isInnerLoading(true);

      var result = await repository.getBannerGroupsByBannerGroupId(id);
      if (result != null && result.length > 0) {
        kokuTestiBanners(result);
      }
      isInnerLoading(false);
      return result;
    } catch (e) {
      isInnerLoading(false);
    }
  }
}
