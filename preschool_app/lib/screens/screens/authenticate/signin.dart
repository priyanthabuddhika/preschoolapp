import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:preschool_app/shared/loading.dart';

class SignIn extends StatefulWidget {
// toggle between login and sign in
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Authenticate Variables
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
   bool loading = false;

  // Login state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return loading ? Loading() : Scaffold(
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
                    'Login',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 80),
                  child: Text(
                    'To Your Account',
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
                                decoration: InputDecoration(hintText: 'Email'),
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
                                    setState(() {
                                      loading = true;
                                    });
                                    print(email);
                                    dynamic result = await _auth
                                        .signInwithEmailandPwd(email, password);
                                    if (result == null) {
                                      setState(() {
                                        error =
                                            'Could not sign in with these credentials';
                                            loading = false;
                                      });
                                    } else {
                                      print('Signed In');
                                      print(result);
                                    }
                                  }
                                },
                                color: Colors.greenAccent,
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ),
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
                  'Create New Account',
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                )),
          ],
        )),
      ),
    );
  }
}
