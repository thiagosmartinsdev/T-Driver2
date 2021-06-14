import 'package:intl/intl.dart';

class MovimentacaoModel {
  late int? idMovimentacao;
  late int idTipoMovimentacao;
  late int? idEmpresa;
  late int? idTipoGasto;
  late double valor;
  late DateTime data;

  late String motivo;

  MovimentacaoModel(this.idMovimentacao, this.idTipoMovimentacao,
      this.idEmpresa, this.idTipoGasto, this.valor, this.data);

  MovimentacaoModel.map(dynamic obj) {
    this.idMovimentacao = obj['id_movimentacao'];
    this.idTipoMovimentacao = obj['id_tipo_movimentacao'];
    this.idEmpresa = obj['id_empresa'];
    this.idTipoGasto = obj['id_tipo_gasto'];
    this.valor = obj['valor'];
    // this.data = DateTime.parse(obj['data']);
  }

  Map<String, dynamic> toMap() {
    var mapa = new Map<String, dynamic>();

    mapa['id_movimentacao'] = idMovimentacao;
    mapa['id_tipo_movimentacao'] = idTipoMovimentacao;
    mapa['id_empresa'] = idEmpresa;
    mapa['id_tipo_gasto'] = idTipoGasto;
    mapa['valor'] = valor;
    mapa['data'] = new DateFormat("yyyy-MM-dd hh:mm:ss").format(data);

    return mapa;
  }

  MovimentacaoModel.fromMap(Map<String, dynamic> mapa) {
    this.idMovimentacao = mapa['id_movimentacao'];
    this.idTipoMovimentacao = mapa['id_tipo_movimentacao'];
    this.idEmpresa = mapa['id_empresa'];
    this.idTipoGasto = mapa['id_tipo_gasto'];
    this.valor = mapa['valor'];
    this.data = mapa['data'];
  }

  MovimentacaoModel.sqlFromMap(Map<String, dynamic> mapa) {
    this.idMovimentacao = mapa['id_movimentacao'];
    this.motivo = mapa['motivo'];
    this.idTipoMovimentacao = mapa['tipoMov'];
    this.valor = mapa['valor'];
    this.data = DateTime.parse(mapa['data']);
  }
}
