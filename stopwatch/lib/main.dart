import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const StopWatch());
}

class StopWatch extends StatelessWidget {
  const StopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;

  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
      laps = [];
    });
  }

  void addLap() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localminutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localminutes > 59) {
          localHours++;
          localminutes = 0;
        } else {
          localminutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localminutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "StopWatch App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "$digitHours:$digitMinutes:$digitSeconds",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                  color: const Color(0xff323f68),
                  borderRadius: BorderRadius.circular(8)),
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lap n${index + 1}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          laps[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    fillColor: Colors.white,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      (!started) ? "Start" : "Pause",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    color: Colors.white,
                    onPressed: addLap,
                    icon: const Icon(Icons.flag)),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.white,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.white),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
