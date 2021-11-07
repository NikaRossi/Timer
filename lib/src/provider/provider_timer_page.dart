import 'dart:async';

import 'package:flutter_timer_lecture/src/provider/provider_timer_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProviderTimerPage extends StatelessWidget {
  final int waitTimeInSec;

  const ProviderTimerPage({Key? key, required this.waitTimeInSec}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TimerNotifier(waitTimeInSec.toDouble()),
        child: _ProviderTimerPage());
  }
}


class _ProviderTimerPage extends StatefulWidget {
  const _ProviderTimerPage({Key? key}) : super(key: key);

  @override
  _ProviderTimerPageState createState() => _ProviderTimerPageState();
}

class _ProviderTimerPageState extends State<_ProviderTimerPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TimerNotifier timerNotifier = context.watch<TimerNotifier>();

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: size.height * 0.1,
              width: size.height * 0.1,
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  timerNotifier.restart();
                },
                child: const Icon(Icons.restart_alt),
              )),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: size.height * 0.1,
                  width: size.height * 0.1,
                  margin: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    value: timerNotifier.percent,
                    backgroundColor: Colors.red[800],
                    strokeWidth: 8,
                  )),
              Positioned(
                  child: Text(
                timerNotifier.timeStr,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ))
            ],
          ),
          Container(
              height: size.height * 0.1,
              width: size.height * 0.1,
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  timerNotifier.isRun ? timerNotifier.pause() : timerNotifier.start();
                },
                child: timerNotifier.isRun ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              )),
        ],
      ),
    );
  }
}
