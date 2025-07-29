import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class FourthItem extends StatefulWidget {
  const FourthItem(this.bg,
      {this.showWeekDay = true,
        this.showAPM = true,
        this.orientation = Orientation.portrait,
        Key? key})
      : super(key: key);

  final Uint8List bg;
  final bool? showWeekDay;
  final bool? showAPM;
  final Orientation? orientation;

  @override
  State<FourthItem> createState() => _FourthItemState();
}

class _FourthItemState extends State<FourthItem>
    with AutomaticKeepAliveClientMixin {
  Timer? _timer;

  var weekDayStr = ''.obs;
  var hourMinutesStr = ''.obs;
  var apmStr = ''.obs;

  void _startTimer() {
    getDate();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getDate();
    });
  }

  String _formatDate(DateTime date) {
    final weekday = DateFormat('EEEE').format(date);
    final day = date.day.toString();
    final month = DateFormat('MMM').format(date).toLowerCase();
    return '$weekday $day ${month.toUpperCase()}';
  }

  void getDate() {
    final now = DateTime.now();
    weekDayStr.value = _formatDate(now);
    hourMinutesStr.value =
    '${DateFormat('hh').format(now)}\n${DateFormat('mm').format(now)}';
    apmStr.value = DateFormat('a').format(now).toUpperCase();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Image.memory(
        widget.bg,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
      Transform(
        transform: Matrix4.identity()..rotateZ(pi * 3 / 2),
        alignment: Alignment.center,
        child: <Widget>[
          const SizedBox(
            width: 260,
            height: 260,
          ),
          Transform(
            transform: Matrix4.identity()..rotateZ(pi / 2),
            alignment: Alignment.center,
            child: Obx(() {
              return Text(
                hourMinutesStr.value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 154,
                    height: 0.9,
                    fontWeight: FontWeight.bold),
              );
            }),
          ),
          Positioned(
              top: 0,
              left: 10,
              child: Visibility(
                  visible: widget.showWeekDay == true,
                  child: Obx(() {
                    return Text(
                      weekDayStr.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    );
                  }))),
          Positioned(
              bottom: 0,
              right: 10,
              child: Visibility(
                visible: widget.showAPM == true,
                child: Obx(() {
                  return Text(
                    apmStr.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  );
                }),
              ))
        ].toStack(alignment: Alignment.center),
      ).marginOnly(
          top: widget.orientation == Orientation.portrait ? 100 : 0,
          right: widget.orientation == Orientation.portrait ? 0 : Get.width / 2)
    ].toStack(
        alignment: widget.orientation == Orientation.portrait
            ? Alignment.topCenter
            : Alignment.center);
  }

  @override
  bool get wantKeepAlive => true;
}
