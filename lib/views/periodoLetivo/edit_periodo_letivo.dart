import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';
import 'package:magister_mobile/data/models/PeriodoLetivo.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditPeriodoLetivo extends StatefulWidget {
  final bool edit;
  final PeriodoLetivo periodoLetivo;

  EditPeriodoLetivo(this.edit, {this.periodoLetivo}) : assert(edit == true || periodoLetivo == null);
  @override
  _EditPeriodoLetivoState createState() => _EditPeriodoLetivoState();
}

class _EditPeriodoLetivoState extends State<EditPeriodoLetivo> {
  TextEditingController anoController = new TextEditingController();
  TextEditingController semestreController = new TextEditingController();
  TextEditingController dataInicioController = new TextEditingController();
  TextEditingController dataFimController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      dataInicioController.text = widget.periodoLetivo.dataInicio.toString();
      dataFimController.text = widget.periodoLetivo.dataFim.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Periodo Letivo" : "Novo Periodo Letivo"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/periodo.png"),
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
                        anoController, 
                        "ANO", 
                        Icons.apps,
                        TextInputType.number, 
                        Colors.lightGreen,
                        initialValue:
                            widget.edit ? widget.periodoLetivo.ano.toString() : "s"),
                    formField(
                      semestreController,
                      "SEMESTRE",
                      Icons.apps,
                      TextInputType.number,
                      Colors.lightGreen,
                      initialValue:
                            widget.edit ? widget.periodoLetivo.semestre : "s"
                            ),
                    formField(
                      dataInicioController, 
                      "DATA INÍCIO",
                      Icons.date_range, 
                      TextInputType.datetime, 
                      Colors.lightGreen,
                      initialValue:
                            widget.edit ? widget.periodoLetivo.dataInicio : "s"
                      ),
                    formField(
                      dataFimController, 
                      "DATA FIM", 
                      Icons.date_range, 
                      TextInputType.datetime, 
                      Colors.lightGreen,
                      initialValue:
                            widget.edit ? widget.periodoLetivo.dataFim : "s"
                      ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              child: Text('Salvar'),
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Carregando')));
                } else if (widget.edit == true) {
                  HelperPeriodoLetivo.getInstance().update(new PeriodoLetivo(
                    ano: int.parse(anoController.text),
                    semestre: semestreController.text,
                    dataInicio: dataInicioController.text,
                    dataFim: dataFimController.text,
                  ));
                  Navigator.pop(context);
                } else {
                  await HelperPeriodoLetivo.getInstance().save(
                    new PeriodoLetivo(
                      ano: int.parse(anoController.text),
                      semestre: semestreController.text,
                      dataInicio: dataInicioController.text,
                      dataFim: dataFimController.text,
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