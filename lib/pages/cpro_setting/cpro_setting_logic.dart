import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CproSettingLogic extends GetxController {

  var showWeekDay = true.obs;
  var showAPM = true.obs;
  var autoLandscape = true.obs;
  var appVersion = '1.0.0'.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showWeekDay.value = prefs.getBool('showWeekDay') ?? true;
    showAPM.value = prefs.getBool('showAPM') ?? true;
    autoLandscape.value = prefs.getBool('autoLandscape') ?? true;
    var info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    super.onInit();
  }

}
