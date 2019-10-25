import 'dart:async';
import 'package:magister_mobile/data/models/Professor.dart';
import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:sqflite/sqflite.dart';

class HelperProfessor extends HelperBase<Professor> {
  static final String professorTable = "tb_professor";
  static final String idColumn = 'id';
  static final String matriculaColumn = 'matricula';
  static final String nomeColumn = "nome";
  static final HelperProfessor _instance = HelperProfessor.getInstance();

  factory HelperProfessor() => _instance;
  HelperProfessor.getInstance();

  @override
  Future<int> delete(int id) {
    return db.then((database) async {
      return await database
          .delete(professorTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $professorTable");
        List<Professor> lista = List();
        for (Map m in listMap) {
          lista.add(Professor.fromMap(m));
        }
        return lista;
      });

  @override
  Future<Professor> getFirst(int id) async => db.then((database) async {
        List<Map> maps = await database.query(professorTable,
            columns: [
              idColumn,
              matriculaColumn,
              nomeColumn,
            ],
            where: "$idColumn = ?",
            whereArgs: [id]);

        if (maps.length > 0) {
          return Professor.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $professorTable");
    }));
  }

  @override
  Future<Professor> save(Professor professor) async {
    db.then((database) async {
      await database.insert(professorTable, professor.toMap());
    });
    return professor;
  }

  @override
  Future<int> update(Professor data) async => await db.then((database) {
        return database.update(professorTable, data.toMap(),
            where: "$idColumn = ?", whereArgs: [data.id]);
      });

  
}