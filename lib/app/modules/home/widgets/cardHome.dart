import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/data/model/card_model.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class CardHome extends StatelessWidget {
  final bool cardMensal;
  CardHome({Key key, this.cardMensal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height * 0.2,
        child: GetX<HomeController>(builder: (c) {
          return c.releasesMontlhy.isNotEmpty
              ? Swiper(
                  itemCount: cardMensal
                      ? c.releasesMontlhy.length
                      : c.releasesWeekly.length,
                  index: cardMensal
                      ? c.releasesMontlhy.length - 1
                      : c.releasesWeekly.length - 1,
                  loop: false,
                  scale: 1,
                  viewportFraction: 0.90,
                  itemBuilder: (_, index) {
                    return Card(
                        color:
                            cardMensal ? Color(0xFF607D8B) : Color(0xFF90A4AE),
                        child: Container(
                          padding: EdgeInsets.only(top: Get.height * 0.02),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cardMensal
                                        ? c.releasesMontlhy[index].name
                                        : c.releasesWeekly[index].period,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: Get.height * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.08),
                                      width: Get.width * 0.51,
                                      child: Text("Ganhos",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                    Text("R\u0024 ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    Container(
                                      width: Get.width * 0.24,
                                      child: Text(
                                          cardMensal
                                              ? c.releasesMontlhy[index]
                                                  .earnings
                                                  .toStringAsFixed(2)
                                              : c.releasesWeekly[index].earnings
                                                  .toStringAsFixed(2),
                                          // cards.earnings.toStringAsFixed(2),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: Get.height * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.08),
                                      width: Get.width * 0.51,
                                      child: Text("Gastos",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                    Text("R\u0024 ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    Container(
                                      width: Get.width * 0.24,
                                      child: Text(
                                          // cards.expensive.toStringAsFixed(2),
                                          cardMensal
                                              ? c.releasesMontlhy[index]
                                                  .expensive
                                                  .toStringAsFixed(2)
                                              : c.releasesWeekly[index]
                                                  .expensive
                                                  .toStringAsFixed(2),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                )
              : SizedBox();
        }));
  }
}
