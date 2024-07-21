import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopTimer() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _timer.cancel();
      } else {
        _stopwatch.start();
        _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
          setState(() {});
        });
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _stopwatch.reset();
    });
  }

  String _formattedTime() {
    var milliseconds = _stopwatch.elapsedMilliseconds;
    var hundreds = (milliseconds / 10).truncate() % 100;
    var seconds = (milliseconds / 1000).truncate() % 60;
    var minutes = (milliseconds / 60000).truncate() % 60;
    var hours = (milliseconds / 3600000).truncate();

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}:'
        '${hundreds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STOPWATCH',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: 'SF Pro Rounded',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        backgroundColor: Color(0xFF8E37E5),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFA78EEE),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 220),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _formattedTime(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontFamily: 'SF Pro Rounded',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                        color: Color(0xFF8E37E6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadows: [
                          BoxShadow(
                            color: Color(0xFF7730EB),
                            blurRadius: 5,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ]),
                    child: InkWell(
                      onTap: _startStopTimer,
                      child: Icon(
                        _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                        color: Color(0xFF8E37E6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadows: [
                          BoxShadow(
                            color: Color(0xFF7730EB),
                            blurRadius: 5,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ]),
                    child: InkWell(
                      onTap: _resetTimer,
                      child: Icon(
                        Icons.stop,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
