import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/screens/student_add.dart';
import 'package:temel_widget/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = " Ogrenci Takip Sistemi ";

  Student selectedStudent = Student.withId(0, "", "", 0 );

  List<Student> students = [
    Student.withId(1,"Enes", "Baron", 25),
    Student.withId(2,"Mahmut", "Orhan", 65),
    Student.withId(3,"Aleyna", "Tilki", 45)
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
                      ),
                      title: Text(students[index].firstName +
                          " " +
                          students[index].lastName),
                      subtitle: Text("Sinavdan aldigi not : " +
                          students[index].grade.toString() +
                          "[" +
                          students[index].getStatus +
                          "]"),
                      trailing: buildStatusIcon(students[index].grade),
                      onTap: () {
                        setState(() {
                          selectedStudent = students[index] ;
                        });

                        print(selectedStudent.firstName);
                      },
                    );
                  })),
          Text("Secili ogrenci : " + selectedStudent.firstName),
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: RaisedButton(
                  color: Colors.amber,
                  child: Row(
                    children : <Widget>[
                      Icon(Icons.add),
                      SizedBox(width: 5.0,) ,
                      Text("Yeni Ogrenci"),
                    ],
                  ),
                  onPressed: () {
                    //Alttaki kod ile ana sayfada tiklanan biseyi yeni sayfada aciyosun
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAdd(students)));
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Row(
                    children: <Widget> [
                      Icon(Icons.update),
                      SizedBox(width: 5.0,),
                      Text("Guncelle"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent)));
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: RaisedButton(
                  color: Colors.cyan,
                  child: Row(
                    children:<Widget> [
                      Icon(Icons.delete),
                      SizedBox(width: 5.0,),
                      Text("Sil"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      students.remove(selectedStudent) ;
                    });

                    var mesaj = "Silindi : "+selectedStudent.firstName;
                    mesajGoster(context, mesaj);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("Islem Sonucuu :"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext contex) => alert);
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
