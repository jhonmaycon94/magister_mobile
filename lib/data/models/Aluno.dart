import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/models/curso.dart';

class Aluno {
  int _id;
  String _nomeAluno;
  int _totalCredito;
  String _dataNascimento;
  double _mgp;
  int _idCurso;
  Curso _curso;

  Aluno({int id, String nomeAluno, int totalCredito, String dataNascimento,
         double mgp, int idCurso}){
    this._id = id;
    this._nomeAluno = nomeAluno;
    this._totalCredito = totalCredito;
    this._dataNascimento = dataNascimento;
    this._mgp = mgp;
    this._idCurso = idCurso;
  }

  int get id => _id;
  set id(int id) => this._id = id;

  String get nome => _nomeAluno;
  set nome(String nome) => this._nomeAluno = nome;

  int get totalCredito => _totalCredito;
  set totalCredito(int totalCredito) => this._totalCredito = totalCredito;

  String get dataNascimento => this._dataNascimento;
  set dataNascimento(String dataNascimento) => this._dataNascimento = dataNascimento;

  double get mgp => _mgp;
  set mgp(double mgp) => this._mgp = mgp;

  int get idCurso => this._idCurso;
  set idCurso(int idCurso) => this._idCurso = idCurso;

  Curso get curso => _curso;
  set curso(Curso curso) {
    this._curso = curso;
    this._idCurso = this._curso.id;
  }

  Aluno.fromMap(Map map){
    _id = map[HelperAluno.idColumn];
    _nomeAluno = map[HelperAluno.nomeColumn];
    _totalCredito = map[HelperAluno.totalCreditoColumn];
    _dataNascimento = map[HelperAluno.dataColumn];
    _mgp = map[HelperAluno.mgpColumn];
    _idCurso = map[HelperAluno.idCursoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperAluno.nomeColumn: nome,
      HelperAluno.totalCreditoColumn: totalCredito,
      HelperAluno.dataColumn: dataNascimento,
      HelperAluno.mgpColumn: mgp,
      HelperAluno.idCursoColumn: idCurso,
    };

    if(id != null){
      map[HelperAluno.idColumn] = id;
    }
    return map;
  }

}
