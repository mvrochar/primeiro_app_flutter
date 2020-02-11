import 'package:flutter/material.dart';
import 'package:sistema/input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sistema/data.dart';

var dataSet = new List<Data>();

class FormPage extends StatefulWidget {
  FormPage() {
    dataSet = [];
  }

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  _FormPageState() {
    load();
  }

  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();

  void add() {
    if (myController.text.isEmpty) return;

    setState(() {
      dataSet.add(
        Data(
            funcionario: myController.text,
            aluno: myController1.text,
            valorMensalidade: myController2.text,
            diaHorario: myController3.text,
            vencimento: myController4.text,
            dataPagamento: myController5.text,
            pagou: false),
      );
      save();
    });
  }

  void remove(int index) {
    setState(() {
      dataSet.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Data> result = decoded.map((x) => Data.fromJson(x)).toList();
      //Map é como um for que itera sobre o decoded

      setState(() {
        dataSet = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(dataSet));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Text(
              "Informe os seguintes dados para cadastrar um novo aluno:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Input(controller: myController, labelText: "Professor"),
            SizedBox(
              height: 20,
            ),
            Input(controller: myController1, labelText: "Aluno"),
            SizedBox(
              height: 20,
            ),
            Input(controller: myController2, labelText: "Valor da Mensalidade"),
            SizedBox(
              height: 20,
            ),
            Input(controller: myController3, labelText: "Dia e Horário"),
            SizedBox(
              height: 20,
            ),
            Input(controller: myController4, labelText: "Vencimento"),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    add();
                    Navigator.pop(context, false);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
