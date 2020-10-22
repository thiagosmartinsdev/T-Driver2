import 'package:meta/meta.dart';
import 'package:tdriver2/app/BD/bd.dart';

import 'package:tdriver2/app/data/model/movimentacao.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class MyApiClient {
  final db = BD();
  MyApiClient({@required db});

  getAll() async {
    try {
      var response = await db.getUltimosLancamentos();

      if (response.length != 0) {
        List<MovimentacaoModel> listModel = response.map<MovimentacaoModel>((map) {
          return MovimentacaoModel.sqlFromMap(map);
        }).toList();

        return listModel;

      }
    } on Error catch (e) {
      print(e);
    }
    // try {
    //   var response = await httpClient.get(baseUrl);
    //   if(response.statusCode == 200){
    //     Map<String, dynamic> jsonResponse = json.decode(response.body);
    //       List<MyModel> listMyModel = jsonResponse['data'].map<MyModel>((map) {
    //         return MyModel.fromJson(map);
    //       }).toList();
    //     return listMyModel;
    //   }else print ('erro -get');
    // } catch(_){ }
  }

  // getId(id) async {
  //   try {
  //     var response = await httpClient.get(baseUrl);
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = json.decode(response.body);
  //       // TODO: implement methods!
  //     } else
  //       print('erro -get');
  //   } catch (_) {}
  // }

  // add(obj) async {
  //   try {
  //     var response = await httpClient.post(baseUrl,
  //         headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
  //     if (response.statusCode == 200) {
  //       // TODO: implement methods!
  //     } else
  //       print('erro -post');
  //   } catch (_) {}
  // }

  // edit(obj) async {
  //   try {
  //     var response = await httpClient.put(baseUrl,
  //         headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
  //     if (response.statusCode == 200) {
  //       // TODO: implement methods!
  //     } else
  //       print('erro -post');
  //   } catch (_) {}
  // }

  // delete(obj) async {
  //   try {
  //     var response = await httpClient.delete(baseUrl);
  //     if (response.statusCode == 200) {
  //       // TODO: implement methods!
  //     } else
  //       print('erro -post');
  //   } catch (_) {}
  // }
}
