import 'package:magister_mobile/data/models/Curso.dart';
import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';

class Disciplina{
  int _id;
  String _nomeDisciplina;
  int _creditos;
  String _tipoDisciplina;
  int _horasObrigatorias;
  int _limiteFaltas;
  int _cursoId;

  Disciplina({int id, String nomeDisciplina, int creditos, String tipoDisciplina, 
              int horasObrigatorias, int limiteFaltas, int cursoId}){
                this._id = id;
                this._nomeDisciplina = nomeDisciplina;
                this._creditos = creditos;
                this._tipoDisciplina = tipoDisciplina;
                this._horasObrigatorias = horasObrigatorias;
                this._limiteFaltas = limiteFaltas;
                this._cursoId = cursoId;
              }

  int get id => _id;
  set id(int id) => this._id = id;

  String get nomeDisciplina => _nomeDisciplina;
  set nomeDisciplina(String nomeDisciplina) => this._nomeDisciplina = nomeDisciplina;

  int get creditos => _creditos;
  set creditos(int creditos) => this.creditos = creditos;

  int get horasObrigatorias => _horasObrigatorias;
  set horasObrigatorias(int horas) => this._horasObrigatorias = horas;

  String get tipoDisciplina => _tipoDisciplina;
  set tipoDisciplina(String tipoDisciplina) => this._tipoDisciplina = tipoDisciplina;

  int get limitesFaltas => _limiteFaltas;
  set limiteFaltas (int limite) => this._limiteFaltas = limitesFaltas;

  int get cursoId => _cursoId;
  set cursoId(int id) => this._cursoId = id;

  Disciplina.fromMap(Map map){
    this._id = map[HelperDisciplina.idColumn];
    this._nomeDisciplina = map[HelperDisciplina.nomeDisciplinaColumn];
    this.creditos = map[HelperDisciplina.creditosColumn];
    this.tipoDisciplina = map[HelperDisciplina.tipoDisciplinaColumn];
    this.horasObrigatorias = map[HelperDisciplina.horasObrigatoriasColumn];
    this.limiteFaltas = map[HelperDisciplina.limteFaltasColumn];
    this.cursoId = map[HelperDisciplina.idCursoColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      HelperDisciplina.nomeDisciplinaColumn: nomeDisciplina,
      HelperDisciplina.creditosColumn: creditos,
      HelperDisciplina.tipoDisciplinaColumn: tipoDisciplina,
      HelperDisciplina.horasObrigatoriasColumn: horasObrigatorias,
      HelperDisciplina.limteFaltasColumn: limitesFaltas;
      HelperDisciplina.idCursoColumn: cursoId,
    };

    if(id != null){
      map[HelperDisciplina.idColumn] = id;
    }
    return map;
  }

}