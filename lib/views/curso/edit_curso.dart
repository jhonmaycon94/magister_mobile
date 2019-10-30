import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'package:magister_mobile/data/models/Curso.dart';
import 'package:magister_mobile/data/models/Professor.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditCurso extends StatefulWidget {
  final bool edit;
  final Curso curso;

  EditCurso(this.edit, {this.curso}) : assert(edit == true || curso == null);
  @override
  _EditProfessorState createState() => _EditProfessorState();
}

class _EditProfessorState extends State<EditCurso> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController totalCreditoController = new TextEditingController();
  TextEditingController idProfessorController = new TextEditingController();
  Professor selected;
  String current = "SELECIONE COORDENADOR";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.curso.nomeCurso.toString();
      totalCreditoController.text = widget.curso.totalCredito.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Curso" : "Adicionar Curso"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/curso.png"),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    formField(
                        nomeController,
                        "NOME DO CURSO",
                        Icons.school,
                        TextInputType.text,
                        Colors.deepOrange,
                         initialValue: widget.edit ? widget.curso.nomeCurso : "s"),
                    formField(
                        totalCreditoController,
                        "TOTAL DE CRÉDITO",
                        Icons.place,
                        TextInputType.number,
                        Colors.deepOrange,
                        initialValue: widget.edit ? widget.curso.totalCredito.toString() : "d"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.deepOrange, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperProfessor.getInstance().getAll(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButton<Professor>(
                                items: snapshot.data
                                    .map((professor) => DropdownMenuItem<Professor>(
                                          child: Text(professor.nome),
                                          value: professor,
                                        ))
                                    .toList(),
                                onChanged: (Professor value) {
                                  setState(() {
                                    selected = value;
                                    idProfessorController.text = selected.id.toString();
                                    current = value.nome;
                                  });
                                },
                                isExpanded: false,
                                hint: Text(current),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
              textColor: Colors.white,
              color: Colors.deepOrange,
              child: Text('Salvar'),
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Carregando')));
                } else if (widget.edit == true) {
                  HelperCurso.getInstance().update(new Curso(
                    id: widget.curso.id,
                    nomeCurso: nomeController.text,
                    totalCredito: int.parse(totalCreditoController.text),
                  ));
                  Navigator.pop(context);
                } else {
                  await HelperCurso.getInstance().save(
                    new Curso(
                      nomeCurso: nomeController.text,
                      totalCredito: int.parse(totalCreditoController.text),
                      idCoordenador: int.parse(idProfessorController.text),
                    ),
                  );
                  Navigator.pop(context);
                }
              })
        ],
      ),
    );
  }
}
