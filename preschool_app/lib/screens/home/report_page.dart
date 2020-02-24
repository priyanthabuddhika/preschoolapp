// Child report class

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/services/database_helper.dart';

class ReportPage extends StatefulWidget {
  final String childName;
  final String childAge;
  ReportPage(this.childName, this.childAge);
  @override
  _ReportPageState createState() => _ReportPageState(childName, childAge);
}

class _ReportPageState extends State<ReportPage> {
  DatabaseHelper dbHelper;
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final String name;
  final String age;

  double fullMark = 0;
  int lessonCount = 0;
  String overall = "";
  _ReportPageState(this.name, this.age);
  @override
  void initState() {
    dbHelper = new DatabaseHelper();
    var mark = 0;
    Future getCount() async {
      mark = await dbHelper.getMark(name);
    }

    getCount().then((vlaue) {
      lessonCount = mark;
      double value = mark / 258;
      fullMark = double.parse((value).toStringAsFixed(1));
      setState(() {
        if (fullMark < 0.4) {
          overall = "Normal";
        } else if (fullMark < 0.7) {
          overall = "Good";
        } else {
          overall = "Super";
        }
        print('ldfj' + fullMark.toString());
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    double precentage = fullMark * 100;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Overall Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Card(
            elevation: 4.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: 45.0,
                      child: Icon(FontAwesomeIcons.tasks),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      height: 40.0,
                      child: LinearProgressIndicator(
                          backgroundColor: Color.fromRGBO(209, 224, 224, 0.3),
                          value: fullMark,
                          valueColor: AlwaysStoppedAnimation(Colors.yellow)),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    flex: 2,
                    child: Text('$precentage %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 16.0),
            child: Text(
              "Points",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildTile(
                    color: Colors.pink,
                    icon: FontAwesomeIcons.tasks,
                    title: "Number of lessons learned",
                    data: "$lessonCount",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.green,
                    icon: FontAwesomeIcons.gamepad,
                    title: "Games",
                    data: "3",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: Icons.favorite,
                    title: "Favourite",
                    data: "Letters",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.pink,
                    icon: FontAwesomeIcons.arrowDown,
                    title: "Weak",
                    data: "Relatives",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: FontAwesomeIcons.artstation,
                    title: "Overall",
                    data: "$overall",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              "Child Report",
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              name,
              style: whiteText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Age : $age",
              style: whiteText,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTile(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
