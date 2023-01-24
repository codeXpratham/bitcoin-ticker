import 'dart:convert';

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

class CoinData
{
     //
     //   Future getCoinData(String currency , String crypto) async
     //   {
     //     print(currency);
     //     http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=D58366A3-CBEF-48B2-83CA-FDC4AA63AF28'));
     //     print(response.body);
     //     // http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=D58366A3-CBEF-48B2-83CA-FDC4AA63AF28'));
     //     // print(response.body);
     //
     //     String data = response.body;
     //     print(data);
     //     var decoded = jsonDecode(data);
     //     double price = decoded['rate'];
     //     print(price);
     //     // return  jsonDecode(data);
     //     return price;
     //   }
     // }

  Future getCoinData(String selectedCurrency) async {
    //4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //5: Return a Map of the results instead of a single value.
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      //Update the URL to use the crypto symbol from the cryptoList
      // String requestURL =
      //     '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      // http.Response response = await http.get(requestURL);
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=6DA0F362-46EF-4D13-A67D-6680B5A8C2CC'));
      print(response.body);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
