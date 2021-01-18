class CardModel {
  int id;
  String name;
  String year;
  double earnings;
  double expensive;
  String period;
  String numMes;
  DateTime dataInicial;
  DateTime dataFinal;

  CardModel(
      {id,
      name,
      year,
      gain,
      expensive,
      period,
      numMes,
      dataInicial,
      dataFinal});

  CardModel.sqlFromMap(Map<String, dynamic> json) {
    double ganhos = json['ganhos'];
    double gastos = json['gastos'];

    this.id = json['id'];
    this.name = json['name'];
    this.year = json['ano'];
    this.earnings = ganhos ??= 0.00;
    this.expensive = gastos ??= 0.00;
    this.period = json['periodo'];
    this.numMes = json['numMes'];
    this.dataInicial = json['dataInicial'];
    this.dataFinal = json['dataFinal'];
  }
}
