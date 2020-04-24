import 'dart:async';
import 'dart:convert';
import 'package:coin_dcx/data/MarketData.dart';
import 'package:coin_dcx/data/TickerData.dart';
import 'package:http/http.dart' as http;

class MarketRepository {
  String cryptoUrl = "https://api.coindcx.com/exchange/";

  Future<List<MarketData>> fetchMarket() async {
    http.Response response = await http.get(cryptoUrl + "v1/markets_details");
    final List body = json.decode(response.body);
    final statusCode = response.statusCode;
    print(response.toString());
    if (statusCode != 200 || body == null) {
      throw new Exception("An error ocurred : [Status Code : $statusCode]");
    }
    return body.map((c) => new MarketData.fromJson(c)).toList();
  }

  Future<Map<String, TickerData>> fetchTicker() async {
    http.Response response = await http.get(cryptoUrl + "ticker");
    final List body = json.decode(response.body);
    final statusCode = response.statusCode;
    print(response.toString());
    if (statusCode != 200 || body == null) {
      throw new Exception("An error ocurred : [Status Code : $statusCode]");
    }
    Map<String, TickerData> data = Map();
    body.forEach((c) => {data[c['market']] = new TickerData.fromJson(c)});
    return data;
  }
}
