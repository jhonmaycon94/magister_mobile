import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'package:magister_mobile/data/models/Curso.dart';
import 'package:magister_mobile/data/models/Disciplina.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditDisciplina extends StatefulWidget {
  final bool edit;
  final Disciplina disciplina;

  EditDisciplina(this.edit, {this.disciplina})
      : assert(edit == true || disciplina == null);
  @override
  _EditDisciplinaState createState() => _EditDisciplinaState();
}

class _EditDisciplinaState extends State<EditDisciplina> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController creditoController = new TextEditingController();
  TextEditingController tipoDisciplinaController = new TextEditingController();
  TextEditingController horasObrigatoriasController = new TextEditingController();
  TextEditingController idCursoController = new TextEditingController();
  Curso selected;
  String current = "SELECIONE CURSO";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.disciplina.nomeDisciplina.toString();
      creditoController.text = widget.disciplina.creditos.toString();
      tipoDisciplinaController.text =
          widget.disciplina.tipoDisciplina.toString();
      horasObrigatoriasController.text =
          widget.disciplina.horasObrigatorias.toString();
    }
  }

  void onPressed() async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Carregando')));
    } else if (widget.edit == true) {
      HelperDisciplina.getInstance().update(new Disciplina(
        id: widget.disciplina.id,
        nomeDisciplina: nomeController.text,
        creditos: int.parse(creditoController.text),
        tipoDisciplina: tipoDisciplinaController.text,
        horasObrigatorias: int.parse(horasObrigatoriasController.text),
        cursoId: int.parse(idCursoController.text),
      ));
      Navigator.pop(context);
    } else {
      await HelperDisciplina.getInstance().save(
        new Disciplina(
          nomeDisciplina: nomeController.text,
          creditos: int.parse(creditoController.text),
          tipoDisciplina: tipoDisciplinaController.text,
          horasObrigatorias: int.parse(horasObrigatoriasController.text),
          cursoId: int.parse(idCursoController.text),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Disciplina" : "Adicionar Disciplina"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              onPressed();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/disciplina.png"),
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
                    formField(nomeController, "NOME DA DISCIPLINA",
                        Icons.school, TextInputType.text, Colors.purple,
                        initialValue: widget.edit
                            ? widget.disciplina.nomeDisciplina
                            : "s"),
                    formField(creditoController, "TOTAL DE CRÉDITO", Icons.apps,
                        TextInputType.number, Colors.purple,
                        initialValue: widget.edit
                            ? widget.disciplina.creditos.toString()
                            : "d"),
                    formField(tipoDisciplinaController, "TIPO", Icons.apps,
                        TextInputType.number, Colors.purple,
                        initialValue: widget.edit
                            ? widget.disciplina.tipoDisciplina
                            : "d"),
                    formField(horasObrigatoriasController, "HORAS OBRIGATÓRIAS",
                        Icons.access_time, TextInputType.number, Colors.purple,
                        initialValue: widget.edit
                            ? widget.disciplina.horasObrigatorias.toString()
                            : "s"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.purple, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperCurso.getInstance().getAll(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButton<Curso>(
                                items: snapshot.data
                                    .map((curso) => DropdownMenuItem<Curso>(
                                          child: Text(curso.nomeCurso),
                                          value: curso,
                                        ))
                                    .toList(),
                                onChanged: (Curso value) {
                                  setState(() {
                                    selected = value;
                                    idCursoController.text =
                                        selected.id.toString();
                                    current = value.nomeCurso;
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
        ],
      ),
    );
  }
}
