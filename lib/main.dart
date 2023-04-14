import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

Color mainColor = const Color(0xFFe54d3c);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> times = [15, 20, 25, 30, 35];

  int mins = 0;
  int secs = 0;
  bool isRunning = false;

  void setTimer(int mins, int secs) {
    setState(() {
      this.mins = mins;
      this.secs = secs;
    });
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (mins == 0 && secs == 0) {
        setState(() {
          isRunning = false;
        });
        timer.cancel();
      } else if (secs == 0) {
        setState(() {
          mins--;
          secs = 59;
        });
      } else {
        setState(() {
          secs--;
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor,
        title: Text(
          'POMOTIMER',
          style: GoogleFonts.poppins(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeCard(
                  time: mins,
                ),
                Text(
                  ':',
                  style: GoogleFonts.poppins(
                    fontSize: 55.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white38,
                  ),
                ),
                TimeCard(
                  time: secs,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
            width: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: times.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      mins = times[index];
                      startTimer();
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                      width: 2.5,
                      color: Colors.white38,
                    )),
                    child: Text(
                      '${times[index]}',
                      style: GoogleFonts.poppins(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              pauseTimer();
            },
            iconSize: 90.0,
            icon: const CircleAvatar(
              radius: 80.0,
              backgroundColor: Colors.black26,
              child: Icon(
                Icons.pause_rounded,
                size: 50.0,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundAndGoal(
                thisText: 0,
                totalText: 4,
                text: 'ROUND',
              ),
              RoundAndGoal(
                thisText: 0,
                totalText: 12,
                text: 'GOAL',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundAndGoal extends StatelessWidget {
  RoundAndGoal({
    required this.thisText,
    required this.totalText,
    required this.text,
    super.key,
  });

  int thisText;
  int totalText;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$thisText/$totalText',
          style: GoogleFonts.poppins(
            fontSize: 25.0,
            color: Colors.white38,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(text,
            style: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ],
    );
  }
}

class TimeCard extends StatelessWidget {
  TimeCard({
    super.key,
    required this.time,
  });

  int time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Card(
          elevation: 0.0,
          color: Colors.white,
          child: SizedBox(
            height: 175.0,
            width: 140.0,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -3),
          child: Container(
            height: 175.0,
            width: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.white54,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -7),
          child: Container(
            height: 175.0,
            width: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.white54,
            ),
          ),
        ),
        Text('$time',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 90.0,
              color: mainColor,
            )),
      ],
    );
  }
}
