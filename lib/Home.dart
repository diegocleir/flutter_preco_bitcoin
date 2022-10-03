import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  _atualiarPrecoBitcoin() async{
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = jsonDecode(response.body);
    //print("Resultado: " + retorno["BRL"]["buy"].toString());

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("imagens/bitcoin.png"),
            Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "R\$ ${_preco}",
                style: TextStyle(
                    fontSize: 35
                ),
              ),
            ),
            ElevatedButton(
              child: Text(
                  "Atualizar",
                  style: TextStyle(
                  fontSize: 20,
                    color: Colors.white
                )
              ),
              onPressed: _atualiarPrecoBitcoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                  padding: const EdgeInsets.all(10),
                ),
            )
          ],
        ),
      ),
    );
  }
}
