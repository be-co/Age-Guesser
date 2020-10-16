import 'package:flutter/material.dart';

/// Widget that provides the text field for the user's name and a submit button
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                ),

                /// Validate the text provided by the user
                validator: (value) {
                  /// No text provided
                  if (value.isEmpty) {
                    return 'Please enter your name';

                    /// More than one word provided
                  } else if (value.trim().split(" ").length != 1) {
                    _textEditingController.clear();
                    return 'Please only enter your first name (single word)';

                    /// Text too long
                  } else if (value.length >= 22) {
                    return 'Your name is too long, sorry :(';
                  }

                  /// Everything is fine, proceed
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),

              /// Button that fits the screen width (minus padding on both sides)
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    /// Validate text entered by the user
                    if (_formKey.currentState.validate()) {
                      /// Send name back to the parent widget to initiate web request
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
