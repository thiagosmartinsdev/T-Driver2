import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/earnings_repository.dart';
import 'package:tdriver2/app/modules/earnings/earnings_controller.dart';

class EarningsPage extends GetView<EarningsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EarningsPage')),
      body: Container(
        child: GetX<EarningsController>(
            init: EarningsController(
                repository:
                    EarningsRepository(apiClient: MyApiClient(db: BD()))),
            builder: (_) {
              return Container();
            }),
      ),
    );
  }
}
