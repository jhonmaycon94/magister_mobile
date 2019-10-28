import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "magister_mobile.db";
  Database _database;

  Future<T> getFirst(int id);
  Future<T> save(T object);
  Future<int> delete(int id);
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
        // Falta referencia a coluna do coordenador do curso.
        "CREATE TABLE IF NOT EXISTS ${HelperCurso.cursoTable}(${HelperCurso.idColumn} INTEGER PRIMARY KEY, ${HelperCurso.nomeColumn} TEXT, ${HelperCurso.totalCreditoColumn} INTEGER, ${HelperCurso.idCoordenadorColumn} INTEGER)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperProfessor.professorTable}(${HelperProfessor.idColumn} INTEGER PRIMARY KEY, ${HelperProfessor.nomeColumn} TEXT, ${HelperProfessor.matriculaColumn} TEXT)");
  }
}
