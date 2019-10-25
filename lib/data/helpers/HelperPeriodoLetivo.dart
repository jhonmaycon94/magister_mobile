import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/models/PeriodoLetivo.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class HelperPeriodoLetivo extends HelperBase<PeriodoLetivo>{
  static final String periodoLetivoTable = "tb_periodo_letivo";
  static final String anoColumn = "ano";
  static final String semestreColumn = "semestre";
  static final String dataInicioColumn = "data_incio";
  static final String dataFimColumn = "data_fim";


  @override
  Future<int> delete(int ano) {
    return db.then((database) async {
      return await database
          .delete(periodoLetivoTable, where: "$anoColumn = ?", whereArgs: [ano]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $periodoLetivoTable");
        List<PeriodoLetivo> lista = List();
        for (Map m in listMap) {
          lista.add(PeriodoLetivo.fromMap(m));
        }
        return lista;
      });

  @override
  Future<PeriodoLetivo> getFirst(int ano) async => db.then((database) async {
        List<Map> maps = await database.query(periodoLetivoTable,
            columns: [
              semestreColumn,
              dataInicioColumn,
              dataFimColumn,
            ],
            where: "$anoColumn = ?",
            whereArgs: [ano]);

        if (maps.length > 0) {
          return PeriodoLetivo.fromMap(maps.first);
        } else {
          return null;
        }
      });


  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $periodoLetivoTable");
    }));
  }

  @override
  Future<PeriodoLetivo> save(PeriodoLetivo periodoLetivo) async {
    db.then((database) async {
      await database.insert(periodoLetivoTable, periodoLetivo.toMap());
    });
    return periodoLetivo;
  }

  @override
  Future<int> update(PeriodoLetivo data) async => await db.then((database) {
        return database.update(periodoLetivoTable, data.toMap(),
            where: "$anoColumn = ?", whereArgs: [data.ano]);
      });


}