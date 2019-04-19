import 'package:flutter/material.dart';
import 'about_configuration.dart';


class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text("$about_page_title",),),
      body : new Container(
        child: new ListView(children: <Widget> [about_spec_1,about_spec_2,about_spec_3,about_spec_4],
        ),
      )
    );
  }
}