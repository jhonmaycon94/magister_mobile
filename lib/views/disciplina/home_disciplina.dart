import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/models/Disciplina.dart';
import 'package:magister_mobile/views/aluno/edit_aluno.dart';

class HomeDisciplina extends StatefulWidget {
  @override
  _HomeDisciplinaState createState() => _HomeDisciplinaState();
}

class _HomeDisciplinaState extends State<HomeDisciplina> {
  @override
  void didUpdateWidget(HomeDisciplina oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DISCIPLINAS"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List>(
        future: HelperDisciplina.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Disciplina item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.purple),
                  onDismissed: (direction) {
                    HelperDisciplina.getInstance().delete(item.id);
                  },
                  child: ListTile(
                    title: Text(item.nomeDisciplina.toString()),
                    leading: CircleAvatar(child: Text(item.id.toString()), backgroundColor: Colors.purple,),
                    onTap: () { /*
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditDisciplina(
                                true,
                                disciplina: item,
                              )));
                    */},
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
        backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () { /*
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditDisciplina(false)));
          */}),
    );
  }
}
