import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(Spongebobify());

class Spongebobify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text("Spongebobify"),
          ),
        ),
        floatingActionButton: MyFab(),
        body: TextInput(),
      ),
    );
  }
}

//text field widget
class TextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (String text) {
          String s = text;
          var cap = s.toUpperCase();
          var low = s.toLowerCase();
          final _random = Random();
          var list = [cap, low];
          var textR = list[_random.nextInt(list.length)];
          text.substring(textR.length);
          print('$textR');

        },
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Enter your text here'),
      ),
    );
  }
}

//FAB widget
class MyFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //spongebobifies text
      },
      child: Icon(Icons.play_arrow),
    );
  }
}
