import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';

class ItemUltimosLancamentos extends StatelessWidget {
  final MovimentacaoModel model;
  const ItemUltimosLancamentos({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.92,
        decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: Offset(1, 4),
                  color: Colors.black45)
            ]),
        height: Get.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: Get.width * 0.05,
              color: model.idTipoMovimentacao == 1
                  ? Colors.green[400]
                  : Colors.red[400],
            ),
            Container(
              width: Get.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.motivo,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy").format(model.data).toString(),
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "R\u0024 " + model.valor.toStringAsFixed(2),
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
