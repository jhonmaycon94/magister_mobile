import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/models/Professor.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditProfessor extends StatefulWidget {
  final bool edit;
  final Professor professor;

  EditProfessor(this.edit, {this.professor})
      : assert(edit == true || professor == null);
  @override
  _EditCursoState createState() => _EditCursoState();
}

class _EditCursoState extends State<EditProfessor> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController matriculaController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.professor.nome.toString();
      matriculaController.text = widget.professor.matricula.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Professor" : "Novo Professor"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.amber,
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
                    formField(nomeController, "NOME", Icons.person,
                        TextInputType.text, Colors.amber,
                        initialValue:
                            widget.edit ? widget.professor.nome : "s"),
                    formField(
                      matriculaController,
                      "MATRÍCULA",
                      Icons.apps,
                      TextInputType.text,
                      Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
              textColor: Colors.white,
              color: Colors.amber,
              child: Text('Salvar'),
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Carregando')));
                } else if (widget.edit == true) {
                  HelperProfessor.getInstance().update(new Professor(
                    id: widget.professor.id,
                    nome: nomeController.text,
                    matricula: matriculaController.text,
                  ));
                  Navigator.pop(context);
                } else {
                  await HelperProfessor.getInstance().save(
                    new Professor(
                      id: 1,
                      matricula: matriculaController.text,
                      nome: nomeController.text,
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
