import 'package:age_guesser/view/history/details_value.dart';
import 'package:flutter/material.dart';

/// Widget that shows the age guess response in a card form
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
            DetailsValue(title: 'Name', value: name, usePadding: true),
            DetailsValue(
                title: 'Your guessed age is:',
                value: age.toString(),
                usePadding: false)
          ],
        ),
      ),
    );
  }
}
