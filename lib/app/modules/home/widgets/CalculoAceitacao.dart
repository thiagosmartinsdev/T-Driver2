import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/widgets/controller/calculo_aceitacao_controller.dart';
// import 'package:tdriver2/app/modules/home/widgets/controller/calculoAceitacaoController.dart';

class CalculoAceitacao extends StatefulWidget {
  @override
  _CalculoAceitacaoState createState() => _CalculoAceitacaoState();
}

class _CalculoAceitacaoState extends State<CalculoAceitacao> {
  final CalculoAceitacaoController controller = Get.find();
  // CalculoAceitacaoController();

  final FocusNode _recebidasFocus = FocusNode();
  final FocusNode _aceitasFocus = FocusNode();

  TextEditingController _txtRecebidas = TextEditingController();
  TextEditingController _txtAceitas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 255, 255, 0.98),
      appBar: AppBar(
        title: Text(
          'Cálculo da taxa de aceitação',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(183, 248, 219, 100),
              Color.fromRGBO(80, 167, 194, 100)
            ])),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Card(
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 24.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    'Insira os dados solicitados',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black54),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Divider(
                      color: Colors.orangeAccent,
                      thickness: 1.5,
                      indent: 45.0,
                      endIndent: 45.0),
                  SizedBox(
                      width: 250,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8),
                          ),
                          TextFormField(
                            controller: _txtRecebidas,
                            textAlign: TextAlign.center,
                            focusNode: _recebidasFocus,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, _recebidasFocus, _aceitasFocus);
                            },
                            onChanged: (text) {
                              // controller.getRecebidas(text);
                            },
                            decoration: InputDecoration(
                                labelText: 'Solicitações recebidas',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide:
                                        new BorderSide(color: Colors.red))),
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                          ),
                          TextFormField(
                            controller: _txtAceitas,
                            textAlign: TextAlign.center,
                            focusNode: _aceitasFocus,
                            onChanged: (text) {
                              // controller.getAceitas(text);
                            },
                            decoration: InputDecoration(
                                labelText: 'Solicitações aceitas',
                                fillColor: Colors.lightBlue,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide())),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  MaterialButton(
                    child: Text('Calcular'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(left: 50, right: 50),
                    disabledColor: Colors.red,
                    disabledTextColor: Colors.white,
                    disabledElevation: 10,
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                    textColor: Colors.white,
                    splashColor: Colors.white,
                    elevation: 8,
                    height: 45,
                    onPressed: () {
                      // controller.calculate(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    // child: Observer(
                    //   builder: (_) {
                    //     return AnimatedDefaultTextStyle(
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.primaries[
                    //             Random().nextInt(Colors.primaries.length)],
                    //       ),
                    //       duration: const Duration(milliseconds: 200),
                    //       child: new Text('${controller.resultado}',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 18)),
                    //     );
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
