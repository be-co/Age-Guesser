import 'package:flutter/material.dart';

class Response extends StatelessWidget {
  final int age;
  final String name;

  Response({@required this.age, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 6.0),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black),
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Text(
              "Name:",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              "$name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
            Text(
              "Your guessed age is:",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              "$age",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
