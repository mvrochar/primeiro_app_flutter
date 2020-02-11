class Data {
  String funcionario;
  String aluno;
  String valorMensalidade;
  String diaHorario;
  String vencimento;
  String dataPagamento;
  bool pagou;

  Data(
      {this.funcionario,
      this.aluno,
      this.valorMensalidade,
      this.diaHorario,
      this.vencimento,
      this.dataPagamento,
      this.pagou}); //Construtor do DART

  Data.fromJson(Map<String, dynamic> json) {
    funcionario = json['funcionario'];
    aluno = json['aluno'];
    valorMensalidade = json['valorMensalidade'];
    diaHorario = json['diaHorario'];
    vencimento = json['vencimento'];
    dataPagamento = json['dataPagamento'];
    pagou = json['pagou'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['funcionario'] = this.funcionario;
    data['aluno'] = this.aluno;
    data['valorMensalidade'] = this.valorMensalidade;
    data['diaHorario'] = this.diaHorario;
    data['vencimento'] = this.vencimento;
    data['dataPagamento'] = this.dataPagamento;
    data['pagou'] = this.pagou;
    return data;
  }
}
