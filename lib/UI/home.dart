import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CLARITY"),
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Container(
            color: Colors.grey,
            child: Text("This is the home page"),
          ),
        ),
      ),
    );
  }
}
