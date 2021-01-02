import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_utils/date_utils.dart';

class BD extends GetxService {
  // criaremos uma variável static, pois nunca irá mudar
  static final BD _instance = new BD.internal();

  // criaremos uma classe factory porque não será recriada sempre que chamarmos a classe BD (POO)
  factory BD() => _instance;

  // internal é um construtor então toda vez que precisamos é só instanciá-lo
  BD.internal();

  // criando o esqueleto da nossa tabela do banco de dados
  final String tabelaEmpresa = "empresas";
  final String colunaDescricao = "descricao";

  final String tabelaMovimentacao = "movimentacao";
  final String colunaIdMovimentacao = "id_movimentacao";
  final String colunaIdTipoMovimentacao = "id_tipo_movimentacao";
  final String colunaIdEmpresa = "id_empresa";
  final String colunaIdTipoGssto = "id_tipo_gasto";
  final String colunaValor = "valor";
  final String colunaData = "data";

  final String tabelaTipoGasto = "tipo_gasto";

  final String tabelaTipoMovimentacao = 'tipo_movimentacao';

  //Database é a classe do SQFlite que iremos usar, por isso iremos criá-la
  static Database _db;

  Future<Database> get db async {
    // se o _db existe na memória
    if (_db != null) {
      //caso exista, retorna este _bd existente
      return _db;
    }
    // chamamos agora o initBd que irá iniciar o nosso banco de dados
    initBd();
    return _db;
  }

  // iniciando nosso banco de dados em async pois ele é uma transição
  Future<Database> initBd() async {
    // Directory faz parte do plugin dart:io e o getApplicationDocumentsDirectory() faz parte do path_provider
    // aqui nós estamos acessando o diretório nativo do android

    print(">>>>>>>>>>>>> INIT DB CALLED<<<<<<<<<<<<<");
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();

    // o join() junta duas coisas, no caso iremos juntar o diretorio juntamente com o nosso banco de dados
    String caminho = join(documentoDiretorio.path, "bd_principal.db");

    // após ter acesso ao local do nosso BD, iremos abri-lo
    Database nossoBD =
        await openDatabase(caminho, version: 1, onCreate: _onCreate);

    print(">>>>>>>>>>>>> CLOSE DB CALLED<<<<<<<<<<<<<");

    _db = nossoBD;

    return nossoBD;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(""
        " CREATE TABLE IF NOT EXISTS $tabelaEmpresa ( "
        "   $colunaIdEmpresa INTEGER PRIMARY KEY,"
        "   $colunaDescricao TEXT "
        " ); ");
    await db.execute(""
        "CREATE TABLE IF NOT EXISTS $tabelaTipoGasto ("
        "   $colunaIdTipoGssto INTEGER PRIMARY KEY, "
        "   $colunaDescricao TEXT "
        "); ");

    await db.execute(""
        "CREATE TABLE IF NOT EXISTS $tabelaTipoMovimentacao ("
        "   $colunaIdTipoMovimentacao INTEGER PRIMARY KEY, "
        "   $colunaDescricao TEXT "
        "); ");

    await db.execute(" CREATE TABLE IF NOT EXISTS $tabelaMovimentacao ("
        "   $colunaIdMovimentacao INTEGER PRIMARY KEY AUTOINCREMENT,"
        "   $colunaIdTipoMovimentacao INTEGER NOT NULL,"
        "   $colunaIdEmpresa INTEGER,"
        "   $colunaIdTipoGssto INTEGER,"
        "   $colunaValor REAL NOT NULL,"
        "   $colunaData DATE TIME NOT NULL,"
        "   FOREIGN KEY ($colunaIdEmpresa) REFERENCES $tabelaEmpresa($colunaIdEmpresa),"
        "   FOREIGN KEY ($colunaIdTipoGssto) REFERENCES $tabelaTipoGasto($colunaIdTipoGssto), "
        "   FOREIGN KEY ($colunaIdTipoMovimentacao) REFERENCES $tabelaTipoMovimentacao($colunaIdTipoMovimentacao) "
        "); ");

    await db.execute(" "
        "INSERT INTO $tabelaEmpresa ($colunaIdEmpresa, $colunaDescricao) "
        " values "
        "   (1, 'Uber' ), "
        "   (2, 'Cabify' ), "
        "   (3, '99 Pop' ), "
        "   (4, 'Particular'); ");
    await db.execute(""
        "INSERT INTO $tabelaTipoGasto ($colunaIdTipoGssto, $colunaDescricao) "
        "values "
        "   (1, 'Combustível' ), "
        "   (2, 'Alimentação' ), "
        "   (3, 'Manutenção' )"
        "; ");

    await db.execute(""
        "INSERT INTO $tabelaTipoMovimentacao ($colunaIdTipoMovimentacao, $colunaDescricao)"
        "values "
        "   (1, 'Ganho' ), "
        "   (2, 'Gasto' ) "
        "; ");
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> REGISTROS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  Future<List<Map<String, dynamic>>> getUltimosLancamentos() async {
    var dbGanho = await db;

    try {
      var res = await dbGanho.rawQuery(""
          "select "
          "   mm.id_movimentacao, "
          " case "
          "   when mm.id_empresa not null then e.descricao "
          "   when mm.id_tipo_gasto not null then tp.descricao "
          " end as motivo, "
          "mm.id_tipo_movimentacao as tipoMov, "
          "mm.valor, "
          "mm.data "
          "from $tabelaMovimentacao mm "
          "left join $tabelaEmpresa e on mm.id_empresa = e.id_empresa "
          "left join $tabelaTipoGasto tp on mm.id_tipo_gasto = tp.id_tipo_gasto "
          "order by mm.id_movimentacao desc  ");

      return res.toList();
    } on DatabaseException catch (e) {
      print("Erro: '$e'");
    }

    return List();
  }

  Future<List> getResumoMensalSemanal(int ano,
      {String mes, DateTime dataInicial, DateTime dataFinal}) async {
    var dbGanho = await db;
    try {
      var res = await dbGanho.rawQuery(""
              "select "
              "   mm.id_movimentacao as id, "
              "   case "
              "     when mm.id_empresa not null then e.descricao "
              "     when mm.id_tipo_gasto not null then tp.descricao "
              "     end as motivo, "
              "   mm.id_tipo_movimentacao as tipoMov, "
              "   mm.valor, "
              "   strftime('%d/%m/%Y' ,mm.data) as data "
              "from $tabelaMovimentacao mm "
              "left join $tabelaEmpresa e on mm.id_empresa = e.id_empresa "
              "left join $tabelaTipoGasto tp on mm.id_tipo_gasto = tp.id_tipo_gasto " +
          (dataInicial == null
              ? "where strftime('%m', data) == '$mes' and strftime('%Y', data) == '$ano' "
              : "where data >= dateTime('$dataInicial') and data < dateTime('$dataFinal') ") +
          "order by strftime('%d/%m/%Y' ,mm.data) asc, mm.id_movimentacao asc ");

      return res.toList();
    } on Exception catch (e) {
      print("Erro: '$e'");
    }
    return new List();
  }

  apagarRegistro(int idRegistro) async {
    var banco = await db;
    try {
      return await banco.delete(tabelaMovimentacao,
          where: "id_movimentacao = ?", whereArgs: [idRegistro]);
    } on DatabaseException catch (e) {
      print(e);
    }
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> GANHOS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  void inserirListaMovimentacao(List<MovimentacaoModel> listaMovimentacao) {
    listaMovimentacao.forEach((mov) => inserirMovimentacao(mov));
  }

  Future<int> inserirMovimentacao(
      MovimentacaoModel movimentacaoMotorista) async {
    var banco = await db;
    try {
      return await banco.insert(
          "$tabelaMovimentacao", movimentacaoMotorista.toMap());
    } on DatabaseException catch (e) {
      print("ERRO: $e");
    }

    return 1;
  }

  Future<List> getGanhosSemana(int ano) async {
    var banco = await db;

    List lista = await banco.rawQuery("select "
        "m.id_movimentacao as id, "
        "m.id_tipo_movimentacao as idMovimentacao, "
        "m.valor, "
        "m.data "
        "from movimentacao m "
        "where strftime('%Y', data) == '$ano' "
        "order by data ");

    return _buildWeeklyList(lista).toList();
  }

  List _buildWeeklyList(List li) {
    List<Map> makedList = new List();
    int id;
    DateTime initialDate;
    DateTime lastDate;
    double ganhos = 0;
    double gastos = 0;

    int x = 0;
    int y = 0;

    // ignore: unnecessary_statements
    for (x; x < li.length; x++) {
      if (x != 39) {
        var lista = li[x];
        initialDate = Utils.firstDayOfWeek(DateTime.parse(lista['data']));
        lastDate = Utils.lastDayOfWeek(DateTime.parse(lista['data']));

        // ignore: unnecessary_statements
        for (y; y < li.length; y++) {
          var lista = li[y];
          if ((DateTime.parse(lista['data']).compareTo(initialDate) == 0 ||
                  DateTime.parse(lista['data']).isAfter(initialDate)) &&
              (DateTime.parse(lista['data']).compareTo(lastDate) == 0 ||
                  DateTime.parse(lista['data']).isBefore(lastDate))) {
            if (lista['idMovimentacao'] == 1) {
              ganhos += lista['valor'];
            } else {
              gastos += lista['valor'];
            }
          } else {
            x = y;
            x--;
            break;
          }
        }

        if (y == li.length) {
          x = y;
        }

        Map<String, Object> mapa = new Map();
        mapa['id'] = id;
        mapa['dataInicial'] = initialDate;
        mapa['dataFinal'] = lastDate;
        mapa['ano'] = initialDate.year.toString();
        mapa['periodo'] =
            DateFormat("dd/MM/yyyy").format(initialDate).toString() +
                " a " +
                DateFormat("dd/MM/yyyy")
                    .format(lastDate.subtract(Duration(days: 1)))
                    .toString();
        mapa['ganhos'] = ganhos;
        mapa['gastos'] = gastos;
        ganhos = 0;
        gastos = 0;

        makedList.add(mapa);
      }
    }
    return makedList;
  }

  Future<List> getGanhosMes(int ano) async {
    var banco = await db;
    var ganhoMensal = await banco.rawQuery(""
        "select "
        " case strftime('%m', data) "
        " when '01' then 'Janeiro' "
        " when '02' then 'Fevereiro' "
        " when '03' then 'Março' "
        " when '04' then 'Abril' "
        " when '05' then 'Maio' "
        " when '06' then 'Junho' "
        " when '07' then 'Julho' "
        " when '08' then 'Agosto' "
        " when '09' then 'Setembro' "
        " when '10' then 'Outubro' "
        " when '11' then 'Novembro' "
        " when '12' then 'Dezembro' "
        " end as name, "
        " strftime('%m', data) as numMes, "
        " strftime('%Y', data) as ano, "
        " sum( "
        "   case when id_tipo_movimentacao = 1 "
        "   then valor "
        "   end "
        " ) as ganhos, "
        " sum( "
        "   case when id_tipo_movimentacao = 2 "
        "   then valor "
        "   end "
        " ) as gastos "
        "from movimentacao "
        "where strftime('%Y', data) == '$ano' "
        "group by strftime('%m', data) ");

    return ganhoMensal.toList();
  }

  Future<List> getGanhosMensalDetalhado() async {
    var banco = await db;
    return await banco.rawQuery(""
        " select "
        " case when e.descricao is not null then e.descricao"
        " else tp.descricao"
        " end as empresa,"
        " sum(m.valor) as valor"
        " from movimentacao m"
        " left join empresas e on m.id_empresa = e.id_empresa"
        " left join tipo_gasto tp on m.id_tipo_gasto = tp.id_tipo_gasto"
        " where"
        " strftime('%m', data) == '08' "
        " and m.id_tipo_movimentacao = 1 "
        " group by e.descricao"
        " order by e.id_empresa");
  }

  Future<String> getTotalGanhoMensal() async {
    var banco = await db;
    var total = await banco.rawQuery(""
        " select "
        " sum(m.valor) as total"
        " from movimentacao m"
        " where"
        " strftime('%m', data) == '08'"
        " and id_tipo_movimentacao = 1");

    return total[0]['total'];
  }

  Future<String> getGastosSemana() async {
    var banco = await db;
    var gasto = await banco.rawQuery(""
        "SELECT SUM(valor) as valor "
        "FROM $tabelaMovimentacao "
        "WHERE id_tipo_movimentacao = 2 and "
        "strftime('%W', data) = strftime('%W', 'now' ) ");

    return gasto[0]['valor'];
  }

  Future<List> getGastosMensalDetalhado() async {
    var banco = await db;
    return await banco.rawQuery(""
        "select"
        "  e.descricao as empresa, "
        "  sum(m.valor) as valor "
        "from movimentacao m "
        "left join empresas e on m.id_empresa = e.id_empresa "
        "where "
        "  m.id_tipo_movimentacao = 1 "
        "  and strftime('%m', data) == '08' "
        "group by e.descricao ");
  }

  Future fechar() async {
    var banco = await db;
    banco.close();
  }
}
