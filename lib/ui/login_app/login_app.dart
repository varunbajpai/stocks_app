import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../search_bar/SearchBar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn  _googleSignIn = new GoogleSignIn();



class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType {
  login,
  register
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Login Stock-Broker"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                  labelText: 'Email'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly, children: <Widget>[
              new RaisedButton(
                child: new Text('Login'),
                onPressed: _loginPressed,
              ),

              new RaisedButton(
                child: new Text('Google Sign In'),
                onPressed: _googleLoginPressed,
              ),
            ],),


            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }





  // These functions can self contain any user auth logic required, they all have access to _email and _password
  Future _loginPressed () async{
    print('The user wants to login with $_email and $_password');
    FirebaseUser login = await _auth.signInWithEmailAndPassword(email: _email, password:_password);
    if(login.uid != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchList()), //On successful Login redirects to LoginApp
      );
    }else{
      print('Invalid Data Entered');
    }
  }





  Future _createAccountPressed() async{				//Creating E-mail Sign In Firebase Authentication
    FirebaseUser user = await _auth.createUserWithEmailAndPassword	//This will go and create user-name and password in the DB
      (email: _email, password:_password ).then((user){
    });
  }




  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
    _auth.sendPasswordResetEmail(email: _email);
  }

    Future<FirebaseUser> _googleLoginPressed() async{			//Creating Google Sign In and integrating it to the app
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      print("signed in" + user.displayName);
      if(user.uid == null){
        print('Not Logged In');
      }
      else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchList()), //On successful Login redirects to LoginApp
        );

      }
      return user;
    }

}