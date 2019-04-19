import 'package:flutter/material.dart';
import 'package:flutter_login_app/ui/login_app/login_app.dart';
import 'package:flutter_login_app/ui/about_page/AboutPage.dart';
import 'package:flutter_login_app/ui/Search_bar/SearchBar.dart';


class DashBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: new Text("Share's Selector",),),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Home"),
              trailing: Icon(Icons.home,),onTap: (){
                Navigator.of(context).pop();
            },
            ),ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.call_missed),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),ListTile(
              title: Text("About"),
              trailing: Icon(Icons.call_missed),
              onTap: (){
//                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            )
          ],
        ),
      ),

      body:
        new Container(
          child: new SearchList(),
        ),

    );
  }
}

class MaterialSearchInput {
}