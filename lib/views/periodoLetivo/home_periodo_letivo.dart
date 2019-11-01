import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';
import 'package:magister_mobile/data/models/PeriodoLetivo.dart';
import 'package:magister_mobile/views/periodoLetivo/edit_periodo_letivo.dart';

class HomePeriodoLetivo extends StatefulWidget {
  @override
  _HomePeriodoLetivoState createState() => _HomePeriodoLetivoState();
}

class _HomePeriodoLetivoState extends State<HomePeriodoLetivo> {
  @override
  void didUpdateWidget(HomePeriodoLetivo oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PERÍODOS LETIVOS"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: FutureBuilder<List>(
        future: HelperPeriodoLetivo.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                PeriodoLetivo item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.lightGreen),
                  onDismissed: (direction) {
                    HelperPeriodoLetivo.getInstance().delete(item.ano, semestre:item.semestre);
                  },
                  child: ListTile(
                    title: Text(item.ano.toString()+'.'+item.semestre.toString()),
                    subtitle: Text(item.dataInicio.toString()+'-'+item.dataFim.toString()),
                    leading: CircleAvatar(backgroundColor: Colors.lightGreen,), 
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPeriodoLetivo(
                                true,
                                periodoLetivo: item,
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
        backgroundColor: Colors.lightGreen,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditPeriodoLetivo(false)));
          }),
    );
  }
}
