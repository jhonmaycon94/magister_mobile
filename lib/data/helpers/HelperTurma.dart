import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/models/Turma.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class HelperTurma extends HelperBase<Turma> {
  static final String turmaTable = "tb_turma";
  static final String anoColumn = "ano";
  static final String semestreColumn = "semestre";
  static final String idDisciplinaColumn = "disciplina_id";
  static final String vagasColumn = "vagas";
  static final String idProfessorColumn = "professor_id";
  static final HelperTurma _instance = HelperTurma.getInstance();

  factory HelperTurma() => _instance;
  HelperTurma.getInstance(); 

  @override
  Future<int> delete(int ano, {semestre}) {
    return db.then((database) async {
      return await database
          .delete(turmaTable, where: "$anoColumn = ? AND $semestreColumn=?", whereArgs: [ano, semestre]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $turmaTable");
        List<Turma> lista = List();
        for (Map m in listMap) {
          lista.add(Turma.fromMap(m));
        }
        return lista;
      });

  @override
  Future<Turma> getFirst(int id) async => db.then((database) async {
        List<Map> maps = await database.query(turmaTable,
            columns: [
              vagasColumn,
              idProfessorColumn,
            ],
            where: "$anoColumn = ? AND $semestreColumn= ? AND $idDisciplinaColumn",
            whereArgs: [id, semestreColumn, idDisciplinaColumn]);

        if (maps.length > 0) {
          return Turma.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $turmaTable");
    }));
  }

  @override
  Future<Turma> save(Turma turma) async {
    db.then((database) async {
      await database.insert(turmaTable, turma.toMap());
    });
    return turma;
  }

  @override
  Future<int> update(Turma data) async => await db.then((database) {
        return database.update(turmaTable, data.toMap(),
            where: "$anoColumn = ? AND $semestreColumn = ? AND $idDisciplinaColumn = ?", whereArgs: [data.ano, data.semestre, data.idDisciplina]);
      });

}