import 'package:flutter/widgets.dart';
import 'package:tdriver2/app/modules/home/widgets/card_home.dart';

class SwipperCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardHome(cardMensal: false),
        CardHome(cardMensal: true),
      ],
    );
  }
}
