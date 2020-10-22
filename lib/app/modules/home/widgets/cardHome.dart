import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class CardHome extends StatelessWidget {
  final bool cardMensal;

  CardHome({Key key, this.cardMensal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height * 0.2,
        child: Swiper(
          itemCount: 3,
          loop: false,
          scale: 1,
          viewportFraction: 0.90,
          itemBuilder: (_, index) {
            return Card(
                color: cardMensal ? Color(0xFFFF7000) : Color(0xFF788993),
                child: Container(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Outubro",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.08),
                              width: Get.width * 0.51,
                              child: Text("Ganhos",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            Text("R\u0024 ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Container(
                              width: Get.width * 0.24,
                              child: Text("15.000,00",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Get.width * 0.08),
                              width: Get.width * 0.51,
                              child: Text("Gastos",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            Text("R\u0024 ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Container(
                              width: Get.width * 0.24,
                              child: Text("150,00",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          },
        ));
  }
}
