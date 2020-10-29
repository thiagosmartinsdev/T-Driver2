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
        child: GetX<HomeController>(builder: (card) {
          return Swiper(
            itemCount: cardMensal ? card.releasesMontlhy.length : card.releasesWeekly.length, 
            index: cardMensal ? card.releasesMontlhy.length -1 : card.releasesWeekly.length - 1,
            loop: false,
            scale: 1,
            viewportFraction: 0.90,
            itemBuilder: (_, index) {
              CardModel cards = cardMensal ? card.releasesMontlhy[index] : card.releasesWeekly[index];
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
                              cardMensal ? cards.name  : cards.period,
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
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.08),
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
                                child: Text(cards.earnings,
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
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.08),
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
                                child: Text(cards.expensive,
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
          );
        }));
  }
}
