import 'package:magister_mobile/data/helpers/HelperTurma.dart';
import 'package:magister_mobile/data/models/Disciplina.dart';
import 'package:magister_mobile/data/models/Professor.dart';

class Turma {
  int _ano;
  String _semestre;
  int _idDisciplina;
  Disciplina _disciplina;
  int _vagas;
  int _idProfessor;
  Professor _professor;

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

  Disciplina get disciplina => _disciplina;
  set disciplina(Disciplina disciplina){
    this._disciplina = disciplina;
    this._idDisciplina = this.disciplina.id;
  }

  Professor get professor => _professor;
  set professor(Professor professor){
    this._professor = professor;
    this.idProfessor = this.professor.id;
  }

  Turma.fromMap(Map map){
    _ano = map[HelperTurma.anoColumn];
    _semestre = map[HelperTurma.semestreColumn];
    _vagas = map[HelperTurma.semestreColumn];
    _idDisciplina = map[HelperTurma.idDisciplinaColumn];
    _idProfessor = map[HelperTurma.idProfessorColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      HelperTurma.semestreColumn: semestre,
      HelperTurma.vagasColumn: vagas,
    };

    if(ano != null){
      map[HelperTurma.anoColumn] = ano;
    }
    return map;
  } 
}