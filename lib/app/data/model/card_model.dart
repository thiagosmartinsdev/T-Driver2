class CardModel {
  late int id;
  late String year;
  late double? earnings;
  late double? expensive;
  late String? period;
  late String? numMes;
  late DateTime? dataInicial;
  late DateTime? dataFinal;

  CardModel(
      {id, year, gain, expensive, period, numMes, dataInicial, dataFinal});

  CardModel.sqlFromMap(Map<String, dynamic> json) {
    double? ganhos = json['ganhos'];
    double? gastos = json['gastos'];
 
    this.id = json['id']?? 0;
    this.year = json['ano'];
    this.earnings = ganhos?? 0.0;
    this.expensive = gastos ?? 0.0;
    this.period = json['periodo'];
    this.numMes = json['numMes'];
    this.dataInicial = json['dataInicial'];
    this.dataFinal = json['dataFinal'];
  }
}
