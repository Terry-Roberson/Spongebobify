import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() => runApp(Spongebobify());

class Spongebobify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  var _finalText = '';

  String _spongebobifyText(String text) {
    List<String> letters = text.split('');
    return letters
        .map((letter) =>
            Random().nextBool() ? letter.toLowerCase() : letter.toUpperCase())
        .toList()
        .join();
  }

  void _onTextChanged() {
    String text = _textEditingController.text;
    if (text.length < _finalText.length + 1) {
      _reroll(text);
      return;
    }
    if (text.length > _finalText.length + 1) {
      _reroll(text);
      return;
    }
    var lastChar = text.substring(text.length - 1);
    lastChar =
        Random().nextBool() ? lastChar.toLowerCase() : lastChar.toUpperCase();
    _append(lastChar);
  }

  void _onTextChangedAutistic() {
    String text = _textEditingController.text;
    print(text.substring(0, _finalText.length).toLowerCase());
    if (text.substring(0, _finalText.length).toLowerCase() ==
        _finalText.toLowerCase()) {
      setState(() {
        _finalText += _spongebobifyText(
            text.substring(_finalText.length, text.length));
      });
      print('true');
    } else {
      print('false');
      setState(() {
        _finalText = _spongebobifyText(text);
      });
    }
  }

  void _clear() {
    _textEditingController.clear();
    setState(() => _finalText = '');
  }

  void _reroll(String text) {
    setState(() => _finalText = _spongebobifyText(text));
  }

  void _append(String char) {
    setState(() => _finalText += char);
  }

  @override
  initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Center(
          child: Text("Spongebobify"),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // textfield
                Container(
                  color: Colors.blue[600],
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _textEditingController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your text here',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        child: Text('Clear'),
                        onPressed: () => _clear(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // results
                (_finalText != '')
                    ? Container(
                        width: double.infinity,
                        color: Colors.blue[600],
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '$_finalText',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isValid = _formKey.currentState.validate();
          if (isValid) {
            Clipboard.setData(ClipboardData(text: _finalText));
          }
        },
        child: Icon(Icons.assignment),
      ),
    );
  }
}
