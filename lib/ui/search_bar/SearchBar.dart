import 'package:flutter_login_app/ui/login_app/login_app.dart';
import '../about_page/AboutPage.dart';
import 'package:flutter/material.dart';
import 'search_configuration.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn  _googleSignIn = new GoogleSignIn();


class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: '$dashboard_title'),
    );
  }
}




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  final duplicateItems = stocks_list;

  bool _checkbox_value1 = false;
  bool _checkbox_value2 = false;
  var items = List<String>();


  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
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
                  _googleSignIn.signOut();
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


        body:  Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Select Your Stock",
                      hintText: "Enter Stock Here",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              new Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                new Text('$show_yearly_results'),
                new Checkbox(
                    value: _checkbox_value1,
                    checkColor: Colors.green.shade900,  // color of tick Mark
                    activeColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _checkbox_value1 = value;
                      });
                    }),
                  new Container(),
                  new Text('$show_monthly_results'),
                  new Checkbox(
                    value: _checkbox_value2,
                    checkColor: Colors.green.shade900,  // color of tick Mark
                    activeColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _checkbox_value2 = value;
                      });
                    })
                ],
              ),
              Expanded(
                child: ListView.builder(

                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child :Text('${items[index][0]}')),
                      title: Text('${items[index]}'),
                      onTap: (){
                        print('${items[index]}');                                 //Will be calling the Neural Network based Code from here
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}