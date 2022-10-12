# Example

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as hardwareBtn;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _latestHardwareButtonEvent;

  StreamSubscription<hardwareBtn.VolumeButtonEvent>? _volumeButtonSubscription;
  StreamSubscription<hardwareBtn.HomeButtonEvent>? _homeButtonSubscription;
  StreamSubscription<hardwareBtn.LockButtonEvent>? _lockButtonSubscription;

  @override
  void initState() {
    super.initState();
    _volumeButtonSubscription = hardwareBtn.volumeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = event.toString();
      });
    });

    _homeButtonSubscription = hardwareBtn.homeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = 'HOME_BUTTON';
      });
    });

    _lockButtonSubscription = hardwareBtn.lockButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = 'LOCK_BUTTON';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _volumeButtonSubscription!.cancel();
    _homeButtonSubscription!.cancel();
    _lockButtonSubscription!.cancel();
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
```
