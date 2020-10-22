import 'package:intl/intl.dart';

class MovimentacaoModel {
  int _idMovimentacao;
  int _idTipoMovimentacao;
  int _idEmpresa;
  int _idTipoGasto;
  String _valor;
  String _data;

  String _motivo;


  MovimentacaoModel(this._idMovimentacao, this._idTipoMovimentacao,
      this._idEmpresa, this._idTipoGasto, this._valor, this._data);

  int get idMovimentacao => _idMovimentacao;

  MovimentacaoModel.map(dynamic obj) {
    this._idMovimentacao = obj['id_movimentacao'];
    this._idTipoMovimentacao = obj['id_tipo_movimentacao'];
    this._idEmpresa = obj['id_empresa'];
    this._idTipoGasto = obj['id_tipo_gasto'];
    this._valor = obj['valor'];
    // this._data = DateTime.parse(obj['data']);
  }


  Map<String, dynamic> toMap() {
    var mapa = new Map<String, dynamic>();

    mapa['idMovimentacao'] = _idMovimentacao;
    mapa['idTipoMovimentacao'] = _idTipoMovimentacao;
    mapa['idEmpresa'] = _idEmpresa;
    mapa['idTipoGasto'] = _idTipoGasto;
    mapa['valor'] = _valor;
    mapa['data'] = _data;
    mapa['motivo'] = _motivo;
    // mapa['data'] = new DateFormat("yyyy-MM-dd hh:mm:ss").format(_data);

    return mapa;
  }

  MovimentacaoModel.fromMap(Map<String, dynamic> mapa) {
    this._idMovimentacao = mapa['id_ganho'];
    this._idTipoMovimentacao = mapa['id_tipo_movimentacao'];
    this._idEmpresa = mapa['id_empresa'];
    this._idTipoGasto = mapa['id_tipo_gasto'];
    this._valor = mapa['valor'];
    this._data = mapa['data'];
  }

  MovimentacaoModel.sqlFromMap(Map<String, dynamic> mapa) {
    this._idMovimentacao = mapa['id_movimentacao'];
    this._motivo = mapa['motivo'];
    this._idTipoMovimentacao = mapa['tipoMov'];
    this._valor = mapa['valor'];
    this._data = mapa['data'];
  }
}
