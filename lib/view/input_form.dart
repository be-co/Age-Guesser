import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  final Function responseCallback;

  InputForm({@required this.responseCallback});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            /*Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
              
            ),
            child: Text(
              'Enter Your Name For An Age Guess',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  } else if (value.trim().split(" ").length != 1) {
                    _textEditingController.clear();
                    return 'Please only enter your first name (single word)';
                  } else if (value.length >= 22) {
                    return 'Your name is too long, sorry :(';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      //fetchAge(_textEditingController.text);
                      /*Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data'))); */
                      responseCallback(_textEditingController.text.trim());
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ));
  }
}
