import 'dart:convert';
import 'dart:io';
import 'package:crypto_stat/coinModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:crypto_stat/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  final List _currencies = (await fetchCoin()) as List;
  print(_currencies);
  runApp(MyApp(_currencies));
}

class MyApp extends StatefulWidget {
  final List _currencies;
  const MyApp(this._currencies);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new homepage(widget._currencies),
    );
  }
}

// String url = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
// Future<List> fetchUsers() async {
//   http.Response response = await http.get(Uri.parse(url));
//   return json.decode(response.body);
// }

Future<List<Coin>> fetchCoin() async {
  coinList = [];
  final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    List<dynamic> values = [];
    values = json.decode(response.body);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          coinList.add(Coin.fromJson(map));
        }
      }
      setState(() {
        coinList;
      });
    }
    return coinList;
  } else {
    throw Exception('Failed to load coins');
  }
}

// List<User> parseUser(String responseBody){
//   var list = json.decode(responseBody) as List<dynamic>;
//   var users = list.map((e) => User.fromJson(e)).toList();
//   return users;
// }

// Future<List<User>> fetchUsers() async{
//   final http.Response response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
        
//         print(response.body);
//     return compute(parseUser,response.body);
    
//   } else {
//     throw Exception(response.statusCode);
//   }
// }
