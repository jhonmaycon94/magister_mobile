import 'package:magister_mobile/data/helpers/HelperTurma.dart';

class Turma {
  int _ano;
  String _semestre;
  int _idDisciplina;
  String _disciplina;
  int _vagas;
  int _idProfessor;
  String _professor;

  Turma({int ano, String semestre, int idDiscilpina, int vagas, int idProfessor}){
    this._ano = ano;
    this._semestre = semestre;
    this._idDisciplina = idDiscilpina;
    this._vagas = vagas;
    this._idProfessor = idProfessor;
  }

  int get ano => _ano;
  set ano(int ano) => this._ano = ano;

  int get idDisciplina => _idDisciplina;
  set idDisciplina(int id) => this._idDisciplina = id;

  int get vagas => _vagas;
  set vagas(int numeroVagas) => this._vagas = vagas;

  int get idProfessor => _idProfessor;
  set idProfessor(int id) => this._idProfessor = id;

  String get semestre => _semestre;
  set semestre (String semestre) => this._semestre = _semestre;

  String get disciplina => _disciplina;
  set disciplina(String disciplina){
    this._disciplina = disciplina;
  }

  String get professor => _professor;
  set professor(String professor){
    this._professor = professor;
  }

  Turma.fromMap(Map map){
    this._ano = map[HelperTurma.anoColumn];
    this._semestre = map[HelperTurma.semestreColumn];
    this._vagas = map[HelperTurma.vagasColumn];
    this._idDisciplina = map[HelperTurma.idDisciplinaColumn];
    this._idProfessor = map[HelperTurma.idProfessorColumn];
    this.disciplina = map[HelperTurma.nomeDisciplinaColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      HelperTurma.vagasColumn: vagas,
      HelperTurma.idProfessorColumn: idProfessor,
      HelperTurma.nomeDisciplinaColumn : disciplina
    };

    if(ano != null && semestre != null){
      map[HelperTurma.anoColumn] = ano;
      map[HelperTurma.semestreColumn] = semestre;
      map[HelperTurma.idDisciplinaColumn] =idDisciplina;
    }
    return map;
  } 
}