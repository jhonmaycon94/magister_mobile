import 'package:flutter/material.dart';
import 'package:magister_mobile/views/aluno/home_aluno.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magister Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("MAGISTER"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            menuCard(Icons.school, "Professor", Colors.amber, null, context),
            menuCard(Icons.school, "Curso", Colors.deepOrange, null, context),
            menuCard(Icons.school, "Aluno", Colors.indigoAccent, HomeAluno(), context),
            menuCard(Icons.school, "Período Letivo", Colors.lightGreen, null, context),
            menuCard(Icons.school, "Turma", Colors.teal, null, context),
            menuCard(Icons.school, "Discilinas", Colors.purple, null, context),
          ],
        ),
      ),
    );
  }
}

Widget menuCard(IconData icon, String nome, Color color, Widget proximo, BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    )),
    color: color,
    margin: EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => proximo,
         ));
      },
      splashColor: Colors.blue,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 80.0,
              color: Colors.white,
            ),
            Text(
              nome.toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),  );
}


