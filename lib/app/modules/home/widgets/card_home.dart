import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class CardHome extends StatelessWidget {
  final bool cardMensal;
  CardHome({Key? key, required this.cardMensal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height * 0.2,
        child: GetBuilder<HomeController>(builder: (controller) {
          var cardData = cardMensal
              ? controller.releasesMontlhy.value
              : controller.releasesWeekly.value;

          return controller.releasesMontlhy.isNotEmpty
              ? Swiper(
                  itemCount: cardData.length,
                  index: cardData.length - 1,
                  loop: false,
                  scale: 1,
                  viewportFraction: 0.90,
                  itemBuilder: (_, index) {
                    return Card(
                        color:
                            cardMensal ? Color(0xFF607D8B) : Color(0xFF90A4AE),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var refresh = await Get.toNamed(
                                        "/details",
                                        arguments: cardData[index],
                                      );
                                      if (refresh) controller.resetHome();
                                    },
                                    child: Text(
                                      cardData[index].period,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Row(
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
                                    child: Text(
                                        cardData[index]
                                            .earnings
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )
                                ],
                              ),
                              Row(
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
                                    child: Text(
                                        cardData[index]
                                            .expensive
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )
                                ],
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
