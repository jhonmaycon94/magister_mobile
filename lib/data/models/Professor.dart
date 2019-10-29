import 'package:magister_mobile/data/helpers/HelperProfessor.dart';

class Professor {
  int _id;
  String _matricula;
  String _nome;

Professor({int id, String matricula, String nome}){
  this._id = id;
  this._matricula = matricula;
  this._nome = nome;
}

int get id => _id;
set id(int id) => this._id = id;

String get matricula => _matricula;
set matricula(String matricula) => this._matricula = matricula;

String get nome => _nome;
set nome(String nome) => this._nome = nome;

Professor.fromMap(Map map){
  _id = map[HelperProfessor.idColumn];
  _matricula = map[HelperProfessor.matriculaColumn];
  _nome = map[HelperProfessor.nomeColumn];
}

Map toMap(){
  Map<String, dynamic> map = {
      HelperProfessor.nomeColumn: nome,
      HelperProfessor.matriculaColumn: matricula,
    };

    if(id != null){
      map[HelperProfessor.idColumn] = id;
    }
    return map;
}
}