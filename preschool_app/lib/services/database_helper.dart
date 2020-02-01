
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:preschool_app/models/report.dart';
// DatabaseHelper for SQFLite 
class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // singleton database helper
  static Database _database; // singleton database

  String reportTable = 'report_table';
  String colId = 'id';
  String colName = 'name';
  String colMarks = 'marks';
  String colLetters = 'letters';
  String colNumbers = 'numbers';
  String colColors = 'colors';
  String colShapes = 'shapes';
  String colVehicles = 'vehicles';
  String colAnimals = 'animals';
  String colRelatives = 'relatives';
  String colBodyParts = 'bodyparts';

  DatabaseHelper._createInstance(); //Named constructor to create instance of DatabaseHelper
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This will be executed once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get getdatabase async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }
// Insert operation
  Future<int> insertReport(Report report) async {
    Database db = await this.getdatabase;
    var result = await db.insert(reportTable, report.toMap());
    return result;

  }

  // Update operation

  Future<int> updateReport(Report report) async {
    var db = await this.getdatabase;
    var result = await db.update(reportTable, report.toMap(),where: '$colId = ?',whereArgs: [report.id]);
    return result;
  }

// Delete operation: 

Future<int> deleteReport(int id) async {
  var db = await this.getdatabase;
  int result = await db.rawDelete('DELETE FROM $reportTable WHERE $colId = $id');
  return result;
}

  Future<Database> initializeDatabase() async {
    // get directory path for android to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'report.db';

    // open/ create db at a given path
    var reportDB = await openDatabase(path, version:1,onCreate: _createDb );
    return reportDB;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $reportTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colMarks INTEGER, $colLetters INTEGER, $colNumbers INTEGER, $colColors INTEGER, $colShapes INTEGER, $colVehicles INTEGER, $colAnimals INTEGER, $colRelatives INTEGER, $colBodyParts INTEGER)');
  }
}
