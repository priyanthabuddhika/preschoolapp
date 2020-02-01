import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:preschool_app/services/database.dart';
// This class helps to select child profile ( It's important to track current progress to each child) 
class SelectChild extends StatefulWidget {
  final List<String> childList;
  SelectChild(this.childList);
  @override
  _SelectChildState createState() => _SelectChildState(childList);
}

class _SelectChildState extends State<SelectChild> {
  final List<String> list;
  _SelectChildState(this.list);

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _currentName;

  // form values
  @override
  void initState() {
    DatabaseService().getStringValuesSF().then(updateName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(list);
    print(_currentName);
    print(_name);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Select your profile',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.0,),
          Text(
            'Currently selected profile is $_name',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 30.0),
          DropdownButtonFormField(
            value: _currentName,
            hint: Text('Select'),
            decoration: InputDecoration(filled: true,fillColor: Colors.cyan[50]),
            items: list.map((name) {
              return DropdownMenuItem(
                value: name,
                child: Text('$name'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 30.0),
          RaisedButton(
            shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
              color: Colors.pink[400],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              onPressed: () async {
                print(_currentName);
                await DatabaseService().addStringToSF(_currentName);
                Navigator.pop(context);
                 Fluttertoast.showToast(
                                          msg: "Profile selected successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
              }),
        ],
      ),
    );
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }
}
