import 'package:uuid/uuid.dart';

class GeneralService {
  var uuid = Uuid();

  getDeviceID() async {
    var deviceID;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('deviceID') == null) {
    //   deviceID = uuid.v1();
    //   prefs.setString('deviceID', deviceID);
    // } else {
    //   deviceID = prefs.getString('deviceID');
    // }
    // return deviceID;
  }
}
