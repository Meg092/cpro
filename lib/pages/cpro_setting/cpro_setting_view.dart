import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'cpro_setting_logic.dart';

class CproSettingView extends GetView<CproSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1011),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Setting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              width: double.infinity,
              height: 57,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[
                const Text(
                  'Display date',
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return Switch(
                      activeTrackColor: Colors.green,
                      value: controller.showWeekDay.value,
                      onChanged: (v) async {
                        controller.showWeekDay.value = v;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('showWeekDay', v);
                      });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                    color: const Color(0xff1f1f1f),
                    borderRadius: BorderRadius.circular(10))
                .marginOnly(bottom: 10),
            Container(
              width: double.infinity,
              height: 57,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[
                const Text(
                  'Display am pm',
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return Switch(
                      activeTrackColor: Colors.green,
                      value: controller.showAPM.value,
                      onChanged: (v) async {
                        controller.showAPM.value = v;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('showAPM', v);
                      });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                    color: const Color(0xff1f1f1f),
                    borderRadius: BorderRadius.circular(10))
                .marginOnly(bottom: 10),
            Container(
              width: double.infinity,
              height: 57,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[
                const Text(
                  'Auto landscape mode',
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return Switch(
                      activeTrackColor: Colors.green,
                      value: controller.autoLandscape.value,
                      onChanged: (v) async {
                        controller.autoLandscape.value = v;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('autoLandscape', v);
                      });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                    color: const Color(0xff1f1f1f),
                    borderRadius: BorderRadius.circular(10))
                .marginOnly(bottom: 10),
            Container(
              width: double.infinity,
              height: 57,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[
                const Text(
                  'About app',
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return Text(
                    controller.appVersion.value,
                    style: const TextStyle(color: Colors.grey),
                  );
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                    color: const Color(0xff1f1f1f),
                    borderRadius: BorderRadius.circular(10))

          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
