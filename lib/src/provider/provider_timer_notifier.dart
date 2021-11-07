import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerNotifier with ChangeNotifier {
  double fullTime;
  late double currentTime;
  bool isRun = false;
  Timer? _timer;

  TimerNotifier(this.fullTime) {
    currentTime = fullTime;
  }

  void start() {
    if (currentTime > 0) {
      isRun = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        currentTime -= 1;
        notifyListeners();
        if (currentTime <= 0) {
          pause();
        }
      });
    }
    notifyListeners();
  }

  void restart() {
    currentTime = fullTime;
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    isRun = false;
    notifyListeners();
  }

  String get timeStr {
    var minuteStr =
    (currentTime ~/ 60).toString().padLeft(2, '0');
    var secondStr =
    (currentTime % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }

  double get percent => currentTime / fullTime;
}
