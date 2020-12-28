class CardModel {
  int id;
  String name;
  String year;
  double earnings;
  double expensive;
  String period;

  CardModel({id, name, year, gain, expensive, period});

  CardModel.sqlFromMap(Map<String, dynamic> json) {
    double ganhos = json['ganhos'];
    double gastos = json['gastos'];

    this.id = json['id'];
    this.name = json['name'];
    this.year = json['ano'];
    // this.earnings = json['ganhos'];
    // this.expensive = json['gastos'];
    this.earnings = ganhos ??= 0.00;
    this.expensive = gastos ??= 0.00;
    this.period = json['periodo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
