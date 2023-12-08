import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  int _start = 0;
  bool _isRunning = false;

  void startOrPauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          _start++;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _start ~/ 3600;
    final minutes = (_start % 3600) ~/ 60;
    final seconds = _start % 60;
    return Expanded(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          GestureDetector(
            onTap: startOrPauseTimer,
            child: Text(
                'Time Spent on Campus: ${hours} h ${minutes} m ${seconds} s',
                style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: startOrPauseTimer,
            child: Text(
              _isRunning ? 'Stop Timer' : 'Start Timer',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
