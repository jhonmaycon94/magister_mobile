import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/models/Professor.dart';

class Curso {
  int _id;
  String _nomeCurso;
  int _totalCredito;
  int _idCoordenador;
  Professor _coordenador;

  Curso({int id, String nomeCurso, int totalCredito, int idCoordenador}){
    this._id = id;
    this._nomeCurso = nomeCurso;
    this._totalCredito = totalCredito;
    this._idCoordenador = idCoordenador;
  }

  int get id => this._id;
  set id(int id) => this._id = id;

  String get nomeCurso => this._nomeCurso;
  set nomeCurso(String nomeCurso) => this._nomeCurso = nomeCurso;

  int get totalCredito => this._totalCredito;
  set totalCredito(int totalCredito) => this._totalCredito = totalCredito;

  int get idCoordenador => this._idCoordenador;
  set idCoordenador(int idCoordenador) => this._idCoordenador = idCoordenador;

  set coordenador(Professor professor) {
     this._coordenador = professor;
     this._idCoordenador = this._coordenador.id;
   }

  Curso.fromMap(Map map){
    _id = map[HelperCurso.idColumn];
    _nomeCurso = map[HelperCurso.nomeColumn];
    _totalCredito = map[HelperCurso.totalCreditoColumn];
    _idCoordenador = map[HelperCurso.idCoordenadorColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperCurso.nomeColumn: nomeCurso,
      HelperCurso.totalCreditoColumn: totalCredito,
      HelperCurso.idCoordenadorColumn: idCoordenador,
    };

    if(id != null){
      map[HelperCurso.idColumn] = id;
    }
    return map;
  }
  
}
