import 'package:flutter/material.dart';
import 'package:sistema/data.dart';
import 'package:sistema/show_information.dart';
import 'package:sistema/form.dart' as form;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class PlanilhaView extends StatefulWidget {
  @override
  _PlanilhaViewState createState() => _PlanilhaViewState();
}

var date = new DateTime.now();

var pagou = new DateFormat("dd/MM/yyyy").format(date);

class _PlanilhaViewState extends State<PlanilhaView> {
  _PlanilhaViewState() {
    load();
  }

  void remove(int index) {
    setState(() {
      form.dataSet.removeAt(index);
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
        form.dataSet = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(form.dataSet));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: PageView.builder(
        itemBuilder: (context, index) {
          final info = form.dataSet[index];
          return Center(
            child: Container(
              height: 550,
              width: 375,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black38, blurRadius: 30.0),
                ],
              ),
              child: SizedBox.expand(
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 30,
                    right: 30,
                  ),
                  children: <Widget>[
                    RaisedButton(
                      child: Icon(Icons.close),
                      onPressed: () {
                        remove(index);
                      },
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShowInformation(
                        text: "Professor: ", data: info.funcionario),
                    SizedBox(
                      height: 20,
                    ),
                    ShowInformation(text: "Aluno: ", data: info.aluno),
                    SizedBox(
                      height: 20,
                    ),
                    ShowInformation(
                        text: "Valor Mensalidade RS: ",
                        data: info.valorMensalidade),
                    SizedBox(
                      height: 20,
                    ),
                    ShowInformation(
                        text: "Dia e Horário: ", data: info.diaHorario),
                    SizedBox(
                      height: 20,
                    ),
                    ShowInformation(
                        text: "Vencimento: ", data: info.vencimento),
                    SizedBox(
                      height: 20,
                    ),
                    ShowInformation(
                        text: "Data de Pagamento: ", data: info.dataPagamento),
                    SizedBox(
                      height: 20,
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Pago",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: info.pagou,
                      onChanged: (value) {
                        setState(
                          () {
                            info.pagou = value;
                            if (value == true) {
                              info.dataPagamento = pagou;
                            } else {
                              info.dataPagamento = ' ';
                            }
                            save();
                            //setState atualiza a tela
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: form.dataSet.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => form.FormPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
    );
  }
}
