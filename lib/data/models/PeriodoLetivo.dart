import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';

class PeriodoLetivo {
  int _ano;
  int _semestre;
  int _dataInicio;
  int _dataFim;

  PeriodoLetivo({int ano, int semestre, int dataInicio, int dataFim}){
    this._ano = ano;
    this._semestre = semestre;
    this._dataInicio = dataInicio;
    this._dataFim = dataFim;
  }

  int get ano => _ano;
  set ano(int ano) => this._ano = ano;

  int get semestre => _semestre;
  set semestre(int semestre) => this._semestre = semestre;

  int get dataInicio => _dataInicio;
  set dataInicio(int data) => this._dataInicio = data;

  int get dataFim => _dataFim;
  set dataFim(int data) => this._dataFim = data;

  PeriodoLetivo.fromMap(Map map){

  }

  Map toMap(){
        Map<String, dynamic> map = {
      HelperPe.nomeColumn: nome,
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