import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';
import 'package:magister_mobile/data/helpers/HelperTurma.dart';
import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "magister_mobile0.db";
  Database _database;

  Future<T> getFirst(int id);
  Future<T> save(T object);
  Future<int> delete(int id, {String semestre});
  Future<int> update(T data);
  Future<List> getAll();
  Future<int> getNumber();

  Future<Database> get db async {
    if (_database != null) {
      _database = await initDb();
      return _database;
      //return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);

    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperAluno.alunoTable}(${HelperAluno.idColumn} INTEGER PRIMARY KEY, ${HelperAluno.nomeColumn} TEXT, ${HelperAluno.totalCreditoColumn} INTEGER, ${HelperAluno.dataColumn} TEXT, ${HelperAluno.mgpColumn} DOUBLE, ${HelperAluno.idCursoColumn} INTEGER, FOREIGN KEY(${HelperAluno.idCursoColumn}) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperCurso.cursoTable}(${HelperCurso.idColumn} INTEGER PRIMARY KEY, ${HelperCurso.nomeColumn} TEXT, ${HelperCurso.totalCreditoColumn} INTEGER, ${HelperCurso.idCoordenadorColumn} INTEGER, FOREIGN KEY(${HelperCurso.idCoordenadorColumn}) REFERENCES ${HelperProfessor.professorTable}(${HelperProfessor.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperProfessor.professorTable}(${HelperProfessor.idColumn} INTEGER PRIMARY KEY, ${HelperProfessor.nomeColumn} TEXT, ${HelperProfessor.matriculaColumn} TEXT)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperDisciplina.disciplinaTable}(${HelperDisciplina.idColumn} INTEGER PRIMARY KEY, ${HelperDisciplina.nomeDisciplinaColumn} TEXT, ${HelperDisciplina.creditosColumn} INTEGER, ${HelperDisciplina.tipoDisciplinaColumn} TEXT, ${HelperDisciplina.horasObrigatoriasColumn} INTEGER, ${HelperDisciplina.limteFaltasColumn} INTEGER, ${HelperDisciplina.idCursoColumn} INTEGER, FOREIGN KEY(${HelperDisciplina.idCursoColumn}) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperTurma.turmaTable}(${HelperTurma.anoColumn} INTEGER, ${HelperTurma.semestreColumn} TEXT, ${HelperTurma.idDisciplinaColumn} INTEGER, ${HelperTurma.vagasColumn} INTEGER, ${HelperTurma.idProfessorColumn} INTEGER, FOREIGN KEY(${HelperTurma.anoColumn}) REFERENCES ${HelperPeriodoLetivo.periodoLetivoTable}(${HelperPeriodoLetivo.anoColumn}), FOREIGN KEY(${HelperTurma.semestreColumn}) REFERENCES ${HelperPeriodoLetivo.periodoLetivoTable}(${HelperPeriodoLetivo.semestreColumn}), FOREIGN KEY(${HelperTurma.idDisciplinaColumn})  REFERENCES ${HelperDisciplina.disciplinaTable}(${HelperDisciplina.idColumn}), FOREIGN KEY(${HelperTurma.idProfessorColumn}) REFERENCES ${HelperProfessor.professorTable}(${HelperProfessor.idColumn}), PRIMARY KEY(${HelperTurma.anoColumn}, ${HelperTurma.semestreColumn}, ${HelperTurma.idDisciplinaColumn}))");
    await db.execute(
    "CREATE TABLE IF NOT EXISTS ${HelperPeriodoLetivo.periodoLetivoTable}(${HelperPeriodoLetivo.anoColumn} INTEGER, ${HelperPeriodoLetivo.semestreColumn} TEXT, ${HelperPeriodoLetivo.dataInicioColumn} TEXT, ${HelperPeriodoLetivo.dataFimColumn} TEXT, PRIMARY KEY(${HelperPeriodoLetivo.anoColumn}, ${HelperPeriodoLetivo.semestreColumn}))");    
  }
}
