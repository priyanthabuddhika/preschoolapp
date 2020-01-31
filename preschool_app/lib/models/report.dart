// Report model class for SQFLITE database
class Report {
  int id;
  int marks;
  String childName;
  int letters;
  int numbers;
  int colors;
  int shapes;
  int vehicles;
  int animals;
  int relatives;
  int bodyparts;

  // Constructor for REport class
  Report(
      {this.childName,
      this.id,
      this.marks,
      this.animals,
      this.bodyparts,
      this.colors,
      this.letters,
      this.numbers,
      this.relatives,
      this.shapes,
      this.vehicles});

// Getters for report variables
  int get getid => id;
  int get getmarks => marks;
  String get getchildname => childName;
  int get getletters => letters;
  int get getnumbers => numbers;
  int get getcolors => colors;
  int get getshapes => shapes;
  int get getvehicles => vehicles;
  int get getanimals => animals;
  int get getrelatives => relatives;
  int get getbodyparts => bodyparts;

// Setters for report class variables
  set setmarks(int newmarks) {
    this.marks = newmarks;
  }

  set setletters(int newletter) {
    this.letters = newletter;
  }

  set setnumbers(int newnumber) {
    this.numbers = newnumber;
  }

  set setcolors(int newcolor) {
    this.colors = newcolor;
  }

  set setshapes(int newshape) {
    this.shapes = newshape;
  }

  set setvehicles(int newvehicle) {
    this.vehicles = newvehicle;
  }

  set setanimals(int newanimal) {
    this.animals = newanimal;
  }

  set setrelatives(int newrelative) {
    this.relatives = newrelative;
  }

  set setbodypart(int newbodypart) {
    this.bodyparts = newbodypart;
  }

  // convert report object into a map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['marks'] = marks;
    map['childname'] = childName;
    map['letters'] = letters;
    map['numbers'] = numbers;
    map['colors'] = colors;
    map['shapes'] = shapes;
    map['vehicles'] = vehicles;
    map['animals'] = animals;
    map['relatives'] = relatives;
    map['bodyparts'] = bodyparts;

    return map;
  }
// Named Constructor for initialize report object from map object 
  Report.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.childName = map['childname'];
    this.letters = map['letters'];
    this.numbers = map['numbers'];
    this.colors = map['colors'];
    this.shapes = map['shapes'];
    this.vehicles = map['vehicles'];
    this.animals = map['animals'];
    this.relatives = map['relatives'];
    this.bodyparts = map['bodyparts'];
  }
}
