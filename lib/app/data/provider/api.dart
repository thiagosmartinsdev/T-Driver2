import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/model/card_model.dart';

import 'package:tdriver2/app/data/model/movimentacao.dart';

class MyApiClient {
  final db = BD();
  MyApiClient({@required db});

  Future getAll(currentYear) async {
    try {
      var releases = await db.getUltimosLancamentos(currentYear.value);
      var monthly = await db.getGanhosMes(currentYear.value);
      var weekly = await db.getGanhosSemana(currentYear.value);
      List<MovimentacaoModel> listReleases;
      List<CardModel> listMonthly;
      List<CardModel> listWeekly;

      if (releases.length != 0) {
        listReleases = releases.map<MovimentacaoModel>((map) {
          return MovimentacaoModel.sqlFromMap(map);
        }).toList();
      }

      if (monthly.length != 0) {
        listMonthly = monthly.map<CardModel>((map) {
          return CardModel.sqlFromMap(map);
        }).toList();
      }

      if (weekly.length != 0) {
        listWeekly = weekly.map<CardModel>((map) {
          return CardModel.sqlFromMap(map);
        }).toList();
      }

      Map<String, List> mapa = Map();
      mapa['releases'] = listReleases;
      mapa['monthly'] = listMonthly;
      mapa['weekly'] = listWeekly;

      return mapa;
    } on Error catch (e) {
      print(e.toString());
      return;
    }
  }

  Future add(obj) async {
    try {
      db.inserirListaMovimentacao(obj);
    } on DatabaseException catch (error) {
      print(error);
    }
  }

  getId(obj) async {
    try {
      var resume = await db.getResumoMensalSemanal(int.parse(obj.year),
          mes: obj.numMes,
          dataInicial: obj.dataInicial,
          dataFinal: obj.dataFinal);

      List<MovimentacaoModel> releasesResume;

      if (resume.length != 0) {
        releasesResume = resume.map<MovimentacaoModel>((map) {
          return MovimentacaoModel.sqlFromMap(map);
        }).toList();
      }
      return releasesResume;
    } on Error catch (e) {
      print(e);
    }
  }

  delete(id) async {
    try {
      db.apagarRegistro(id);
    } on DatabaseException catch (error) {
      print(error);
    }
  }
}
