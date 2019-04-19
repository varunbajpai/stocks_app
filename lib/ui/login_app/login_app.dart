import 'package:validate/validate.dart';
import 'package:flutter/material.dart';
import '../search_bar/SearchBar.dart';


class _LoginData {
  String email = '';
  String password = '';
}


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }



  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }



  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();                     // Save our form now
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');

      //Define and run query on database here and then do something here
      //Maybe if you want to implement OAUTH or something this is the place to do
      if(_data.email == "varun@gmail.com" && _data.password =="varun123"){
        print("Login Successfull");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchList()),
        );
      }
      else{
        this._formKey.currentState.reset();
      }
    }
  }


  
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new WillPopScope( onWillPop: () async => false,child: new Scaffold(
      appBar: new AppBar(
        leading: new Container(child: Center(child: new Text('Login', textAlign: TextAlign.left, textScaleFactor:1.5,),)),
//        title: new Text('Login', textAlign: TextAlign.left,),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                    initialValue: "varun@gmail.com",
                    decoration: new InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'E-mail Address'
                    ),
                    validator: this._validateEmail,
                    onSaved: (String value) {
                      this._data.email = value;
                    }
                ),
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    initialValue: "varun123",
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password'
                    ),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.password = value;
                    }
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Login',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    ),);
  }
}