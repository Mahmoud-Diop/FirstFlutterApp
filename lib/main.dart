import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Jour Aleatoire ",
      home: Horloge(),
    );
  }
}

class Horloge extends StatefulWidget {
  const Horloge({super.key});

  @override
  State<Horloge> createState() => _Horloge();
}

class _Horloge extends State<Horloge> {
  String _heureCourante = "00";
  String _minuteCourante = "00";
  String _secondCourante = "00";
  bool _startHorloge = false;
  late Timer _timerHorloge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFe664645), Color(0xFF9198e5)],
            ),
          ),
          child: buildColumnCentral(),
        ),
      ),
    );
  }

  ElevatedButton buildStartButton() {
    return ElevatedButton(
      onPressed: () {
        if (!_startHorloge) {
          _startHorloge = !_startHorloge;
          startHorloge();
        }
      },
      child: Icon(Icons.play_arrow, size: 25, color: Colors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[800],
        minimumSize: Size(100, 50),
      ),
    );
  }

  ElevatedButton buildPauseButton() {
    return ElevatedButton(
      onPressed: () {
        if (_startHorloge) {
          _startHorloge = !_startHorloge;
          stopHorloge();
        }
      },
      child: Icon(Icons.pause, color: Colors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: Size(100, 50),
      ),
    );
  }

  Row buildButtonRowControles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildStartButton(), buildPauseButton()],
    );
  }

  Widget buildAfficheHorraire(value, texte) {
    return Container(
      height: 150,
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$value",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 80,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$texte",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Row buildHeureCourante() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildAfficheHorraire(_heureCourante, "heures"),
        buildAfficheHorraire(_minuteCourante, "minutes"),
        buildAfficheHorraire(_secondCourante, "secondes"),
      ],
    );
  }

  Column buildColumnCentral() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [buildHeureCourante(), buildButtonRowControles()],
    );
  }

  void startHorloge() {
    if (_startHorloge) {
      _timerHorloge = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _heureCourante = DateTime.now().hour.toString().padLeft(2, '0');
          _minuteCourante = DateTime.now().minute.toString().padLeft(2, '0');
          _secondCourante = DateTime.now().second.toString().padLeft(2, '0');
        });
      });
    }
  }

  void stopHorloge() {
    if (!_startHorloge) {
      _timerHorloge.cancel();
    }
  }
}
