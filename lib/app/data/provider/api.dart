import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/model/card_model.dart';

import 'package:tdriver2/app/data/model/movimentacao.dart';

class MyApiClient {
  final db = BD();
  MyApiClient({@required db});

  Future getAll() async {
    try {
      var releases = await db.getUltimosLancamentos();
      var monthly = await db.getGanhosMes(2020);
      var weekly = await db.getGanhosSemana(2020);
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

  // getId(id) async {
  //   try {
  //     var response = await httpClient.get(baseUrl);
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = json.decode(response.body);
  //     } else
  //       print('erro -get');
  //   } catch (_) {}
  // }

  // edit(obj) async {
  //   try {
  //     var response = await httpClient.put(baseUrl,
  //         headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
  //     if (response.statusCode == 200) {
  //     } else
  //       print('erro -post');
  //   } catch (_) {}
  // }

  // delete(obj) async {
  //   try {
  //     var response = await httpClient.delete(baseUrl);
  //     if (response.statusCode == 200) {
  //     } else
  //       print('erro -post');
  //   } catch (_) {}
  // }
}
