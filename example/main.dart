import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hardware_button_nullsafety/hardware_button_nullsafety.dart'
    as hardwarebtn;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _latestHardwareButtonEvent;

  StreamSubscription<hardwarebtn.VolumeButtonEvent>? _volumeButtonSubscription;
  StreamSubscription<hardwarebtn.HomeButtonEvent>? _homeButtonSubscription;
  StreamSubscription<hardwarebtn.LockButtonEvent>? _lockButtonSubscription;

  @override
  void initState() {
    super.initState();
    _volumeButtonSubscription = hardwarebtn.volumeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = event.toString();
      });
    });

    _homeButtonSubscription = hardwarebtn.homeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = 'HOME_BUTTON';
      });
    });

    _lockButtonSubscription = hardwarebtn.lockButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = 'LOCK_BUTTON';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _volumeButtonSubscription?.cancel();
    _homeButtonSubscription?.cancel();
    _lockButtonSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Value: $_latestHardwareButtonEvent\n'),
            ],
          ),
        ),
      ),
    );
  }
}
