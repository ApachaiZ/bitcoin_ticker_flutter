import 'dart:convert';

import 'package:bitcoin_ticker_flutter/utility/constant.dart';
import 'package:http/http.dart' as http;
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getCoinData({required String crypto, required String currency}) async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['rate']);
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}

