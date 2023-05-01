import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const Pomodoro());
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;
  double percent = 0;

  _startTimer() {
    Timer timer;
    TimeInMinut = 25;
    int Time = TimeInMinut * 60;
    double secPercent = (Time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInSec--;
          }
          if (Time % secPercent == 0) {
            if (percent < 1) {
              percent += .01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinut = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                      begin: FractionalOffset(0.5, 1))),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      'Pomodoro clock',
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: CircularPercentIndicator(
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: percent,
                      animation: true,
                      animateFromLastPercent: true,
                      radius: 130,
                      lineWidth: 20,
                      progressColor: Colors.white,
                      center: Text(
                        "${TimeInMinut}",
                        style: TextStyle(color: Colors.white, fontSize: 48),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Study Timer",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "25",
                                          style: TextStyle(
                                            fontSize: 80,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Pause Timer",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "5",
                                          style: TextStyle(
                                            fontSize: 80,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 28),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue)),
                                  child: Text(
                                    'Start',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: _startTimer,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
