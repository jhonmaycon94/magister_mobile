class Turma {
  int _ano;
  String _semestre;
  int _idDisciplina;
  int _vagas;
  int _idProfessor;

  Turma({int ano, String semeste, int idDiscilpina, int vagas, int idProfessor}){
    this._ano = ano;
    this._semestre = semeste;
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

  Turma.fromMap(Map map){

  }

  Map toMap(){
    
  } 
}