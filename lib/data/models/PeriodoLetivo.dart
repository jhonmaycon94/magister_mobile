import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';

class PeriodoLetivo {
  int _ano;
  String _semestre;
  String _dataInicio;
  String _dataFim;

  PeriodoLetivo({int ano, String semestre, String dataInicio, String dataFim}){
    this._ano = ano;
    this._semestre = semestre;
    this._dataInicio = dataInicio;
    this._dataFim = dataFim;
  }

  int get ano => _ano;
  set ano(int ano) => this._ano = ano;

  String get semestre => _semestre;
  set semestre(String semestre) => this._semestre = semestre;

  String get dataInicio => _dataInicio;
  set dataInicio(String data) => this._dataInicio = data;

  String get dataFim => _dataFim;
  set dataFim(String data) => this._dataFim = data;

  PeriodoLetivo.fromMap(Map map){
    _ano = map[HelperPeriodoLetivo.anoColumn];
    _semestre = map[HelperPeriodoLetivo.semestreColumn];
    _dataInicio = map[HelperPeriodoLetivo.dataInicioColumn];
    _dataFim = map[HelperPeriodoLetivo.dataFimColumn]; 
  }

  Map toMap(){
        Map<String, dynamic> map = {
      HelperPeriodoLetivo.dataInicioColumn: dataInicio,
      HelperPeriodoLetivo.dataFimColumn: dataFim,
    };

    if(ano != null && semestre != null){
      map[HelperPeriodoLetivo.anoColumn] = ano;
      map[HelperPeriodoLetivo.semestreColumn] = semestre;
    }
    return map;
  }

}