import 'dart:async';
import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/models/Disciplina.dart';
import 'package:sqflite/sqflite.dart';

class HelperDisciplina extends HelperBase<Disciplina> {
  static final String disciplinaTable = "tb_disciplina";
  static final String idColumn = "id";
  static final String nomeDisciplinaColumn = "nome_disciplina";
  static final String creditosColumn ="creditos";
  static final String tipoDisciplinaColumn = "tipo_disciplina";
  static final String horasObrigatoriasColumn = "horas_obrigatorias";
  static final String limteFaltasColumn = "limite_faltas";
  static final String idCursoColumn = "curso_id";
  static final HelperDisciplina _instance = HelperDisciplina.getInstance();

  factory HelperDisciplina() => _instance;
  HelperDisciplina.getInstance();

  @override
  Future<int> delete(int id, {String semestre, int idDisciplina}) {
    return db.then((database) async {
      return await database
          .delete(disciplinaTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $disciplinaTable");
        List<Disciplina> lista = List();
        for (Map m in listMap) {
          lista.add(Disciplina.fromMap(m));
        }
        return lista;
      });

  @override
  Future<Disciplina> getFirst(int id, {String semestre, int idDisciplina}) async => db.then((database) async {
        List<Map> maps = await database.query(disciplinaTable,
            columns: [
              idColumn,
              nomeDisciplinaColumn,
              creditosColumn,
              tipoDisciplinaColumn,
              horasObrigatoriasColumn,
//              limteFaltasColumn,
              idCursoColumn,
            ],
            where: "$idColumn = ?",
            whereArgs: [id]);

        if (maps.length > 0) {
          return Disciplina.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $disciplinaTable");
    }));
  }

  @override
  Future<Disciplina> save(Disciplina disciplina) async {
    db.then((database) async {
      await database.insert(disciplinaTable, disciplina.toMap());
    });
    return disciplina;
  }

  @override
  Future<int> update(Disciplina data) async => await db.then((database) {
        return database.update(disciplinaTable, data.toMap(),
            where: "$idColumn = ?", whereArgs: [data.id]);
      });
  
}