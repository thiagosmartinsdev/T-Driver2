class CardModel {
  int id;
  String name;
  String year;
  String earnings;
  String expensive;
  String period;

  CardModel({id, name, year, gain, expensive, period});

  CardModel.sqlFromMap(Map<String, dynamic> json) {
    try {
      this.id = json['id'];
      this.name = json['name'];
      this.year = json['ano'];
      this.earnings = json['ganhos'];
      this.expensive = json['gastos'];
      this.period = json['periodo'];
    } on Exception catch (e) {
      print("ERRO MODEL " + e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
