import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';

class ItemUltimosLancamentos extends StatelessWidget {
  final Map model;
  final bool green;
  const ItemUltimosLancamentos({Key key, this.model, this.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0XFFF2F5F9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
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
            // height: Get.height * 0.08,
            color: model['idTipoMovimentacao'] == 1
                ? Colors.green[400]
                : Colors.red[400],
          ),
          Container(
            width: Get.width * 0.5,
            padding: EdgeInsets.only(left: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model['motivo'],
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                Text(
                  model['data'],
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.27,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "R\u0024 " + model['valor'],
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
