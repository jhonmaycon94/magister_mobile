import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';
import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/helpers/HelperTurma.dart';
import 'package:magister_mobile/data/models/Disciplina.dart';
import 'package:magister_mobile/data/models/PeriodoLetivo.dart';
import 'package:magister_mobile/data/models/Turma.dart';
import 'package:magister_mobile/data/models/Professor.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditTurma extends StatefulWidget {
  final bool edit;
  final Turma turma;

  EditTurma(this.edit, {this.turma}) : assert(edit == true || turma == null);
  @override
  _EditTurmaState createState() => _EditTurmaState();
}

class _EditTurmaState extends State<EditTurma> {
  TextEditingController vagasController = new TextEditingController();
  TextEditingController professorIdController = new TextEditingController();
  TextEditingController disciplinaIdController = new TextEditingController(); 
  Professor professorSelected;
  Disciplina disciplinaSelected;
  PeriodoLetivo periodoLetivoSelected;
  String currentProfessor = "SELECIONE COORDENADOR";
  String currentPeriodoLetvio = "PERÍODO LETIVO";
  String currentDisciplina = "SELECIONE DISCIPLINA";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      vagasController.text = widget.turma.vagas.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Turma" : "Adicionar Turma"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/professor.png"),
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
                        vagasController,
                        "NÚMERO DE VAGAS",
                        Icons.apps,
                        TextInputType.text,
                        Colors.teal,
                         initialValue: widget.edit ? widget.turma.vagas.toString() : "s"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.teal, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperPeriodoLetivo.getInstance().getAll(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButton<PeriodoLetivo>(
                                items: snapshot.data
                                    .map((periodoLetivo) => DropdownMenuItem<PeriodoLetivo>(
                                          child: Text(periodoLetivo.ano.toString() + "." + periodoLetivo.semestre),
                                          value: periodoLetivo,
                                        ))
                                    .toList(),
                                onChanged: (PeriodoLetivo value) {
                                  setState(() {
                                    periodoLetivoSelected = value;
                                    currentPeriodoLetvio = value.ano.toString()+"."+value.semestre;
                                  });
                                },
                                isExpanded: false,
                                hint: Text(currentPeriodoLetvio),
                              );
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.teal, width: 1),
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
                                    professorSelected = value;
                                    professorIdController.text = professorSelected.id.toString();
                                    currentProfessor = value.nome;
                                  });
                                },
                                isExpanded: false,
                                hint: Text(currentProfessor),
                              );
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.teal, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperDisciplina.getInstance().getAll(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButton<Disciplina>(
                                items: snapshot.data
                                    .map((disciplina) => DropdownMenuItem<Disciplina>(
                                          child: Text(disciplina.nomeDisciplina),
                                          value: disciplina,
                                        ))
                                    .toList(),
                                onChanged: (Disciplina value) {
                                  setState(() {
                                    disciplinaSelected = value;
                                    disciplinaIdController.text = disciplinaSelected.id.toString();
                                    currentDisciplina = value.nomeDisciplina;
                                  });
                                },
                                isExpanded: false,
                                hint: Text(currentDisciplina),
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
              color: Colors.teal,
              child: Text('Salvar'),
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Carregando')));
                } else if (widget.edit == true) {
                  HelperTurma.getInstance().update(new Turma(
                    ano: widget.turma.ano,
                    semestre: widget.turma.semestre,
                    idDiscilpina: widget.turma.idDisciplina,
                    idProfessor: int.parse(professorIdController.text),
                    vagas: int.parse(vagasController.text),
                  ));
                  Navigator.pop(context);
                } else {
                  await HelperTurma.getInstance().save(
                    new Turma(
                      ano: periodoLetivoSelected.ano,
                      semestre: periodoLetivoSelected.semestre,
                      idDiscilpina: int.parse(disciplinaIdController.text),
                      idProfessor: int.parse(professorIdController.text),
                      vagas: int.parse(vagasController.text),
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
