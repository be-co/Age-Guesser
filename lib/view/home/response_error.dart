import 'package:flutter/material.dart';

/// Widget that shows the error message in a card form
class ResponseError extends StatelessWidget {
  const ResponseError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 6.0),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black),
        color: Colors.red,
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
              "There was an error retrieving your age guess. Please try again.",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
