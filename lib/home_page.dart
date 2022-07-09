import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  late List currencies;
  homepage(this.currencies);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto stats"),
      ),
      body: _cryptowidget(),
    );
  }

  Widget _cryptowidget() {
    return new Container(
        child: Column(
          children: [
            new Flexible(
                child: new ListView.builder(
                    itemCount: widget.currencies.length,
                    itemBuilder: ((context, index) {
                      final Map currency = widget.currencies[index];
                      final MaterialColor color = _colors[index % _colors.length];
                      return _getListItemUi(currency, color);
                    }))),
          ],
        ));
  }

  Widget _getListItemUi(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percent) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD\n", style: new TextStyle(color: Colors.black));
    String percentChangeText = "1 hour: $percent";
    TextSpan percentagechangeTextWidget = new TextSpan();
    if (double.parse(percent) > 0) {
      percentChangeText = new TextSpan(
        text: percentagechangeTextWidget.toString(),
        style: const TextStyle(color: Colors.green),
      ) as String;
    } else {
      percentChangeText = new TextSpan(
        text: percentagechangeTextWidget.toString(),
        style: new TextStyle(color: Colors.red),
      ) as String;
    }
    return new RichText(
        text:
            TextSpan(children: [priceTextWidget, percentagechangeTextWidget]));
  }
}
