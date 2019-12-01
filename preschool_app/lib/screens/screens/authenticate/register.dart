import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  // Login States

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 80),
                    child: Text(
                      'New Account',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    alignment: Alignment.topRight,
                    child: Image.asset('images/giraffe.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                      decoration: new BoxDecoration(boxShadow: [
                        new BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5.0,
                            spreadRadius: 0.01),
                      ]),
                      margin: EdgeInsets.fromLTRB(0, 250, 0, 40),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 50.0),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Email'),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an Email' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Password'),
                                    validator: (val) => val.length < 6
                                        ? 'Password must be 6+ char long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        print(email);
                                        print(password);
                                        dynamic result = await _auth
                                            .registerUserwithEmailandPwd(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'Please enter a valid Email !';
                                          });
                                        } else {
                                          print('Signed In');
                                          print(result);
                                        }
                                      }
                                    },
                                    color: Colors.pink[400],
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            FlatButton(
                onPressed: () {
                  widget.toggleView();
                },
                child: Text(
                  'Log In to Your Account',
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                )),],
          ),
        ),
      ),
    );
  }
}
