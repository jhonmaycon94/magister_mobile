import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/models/professor.dart';
import 'package:magister_mobile/views/professor/edit_professor.dart';

class HomeProfessor extends StatefulWidget {
  @override
  _HomeProfessorState createState() => _HomeProfessorState();
}

class _HomeProfessorState extends State<HomeProfessor> {
  @override
  void didUpdateWidget(HomeProfessor oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFESSORES"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List>(
        future: HelperProfessor.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Professor item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.amber),
                  onDismissed: (direction) {
                    HelperProfessor.getInstance().delete(item.id);
                  },
                  child: ListTile(
                    title: Text(item.nome.toString()),
                    subtitle: Text(item.matricula.toString()),
                    leading: CircleAvatar(child: Text(item.id.toString()), backgroundColor: Colors.amber,),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfessor(
                                true,
                              )));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
            child: Icon(Icons.add),
            onPressed: () {  
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfessor(false)));
          }),
    );
  }
}
