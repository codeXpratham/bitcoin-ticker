import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  // PriceScreen({this.coinDAta});
  // final coinDAta;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String bitcoinValueInUSD = '?';


  DropdownButton<String> getDropdownbutton() {
    List<DropdownMenuItem<String>> drop = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> item;
      String dr = currency;
      item = DropdownMenuItem(
        child: Text(dr),
        value: dr,
      );
      drop.add(item);
    }
    // return drop;

    return DropdownButton<String>(
        value: selectedCurrency,
        items: drop,
        onChanged: (value) {
          // print(value);
          setState(() {
            selectedCurrency = value;
            print(value);
            getData();
          });
        });
  }

  // Padding currencyButton( String crypto )
  // {
  //   Future val = getData();
  //    Padding x = Padding(
  //      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
  //      child: Card(
  //        color: Colors.lightBlueAccent,
  //        elevation: 5.0,
  //        shape: RoundedRectangleBorder(
  //          borderRadius: BorderRadius.circular(10.0),
  //        ),
  //        child: Padding(
  //          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
  //          child: Text(
  //            '1 $crypto = $val $selectedCurrency',
  //            textAlign: TextAlign.center,
  //            style: TextStyle(
  //              fontSize: 20.0,
  //              color: Colors.white,
  //            ),
  //          ),
  //        ),
  //      ),
  //    );
  //
  //    return x;
  // }

  CupertinoPicker iOSPicker() {

    List<Widget> tex = [];
    for (String currency in currenciesList) {
      tex.add(Text(currency));
    }
    // return tex;

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: tex,
    );
  }



  // void getData(String currency, {String crypto = 'USD'}) async {
  //
  //   currency = selectedCurrency;
  //   try {
  //     double data = await CoinData().getCoinData(currency,crypto);
  //     //13. We can't await in a setState(). So you have to separate it out into two steps.
  //     setState(() {
  //       bitcoinValueInUSD = data.toStringAsFixed(0);
  //       print(bitcoinValueInUSD);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // Future getData(String currency, {String crypto = 'USD'}) async {
  //   String x;
  //   currency = selectedCurrency;
  //   try {
  //     double data = await CoinData().getCoinData(currency,crypto);
  //     //13. We can't await in a setState(). So you have to separate it out into two steps.
  //     setState(() {
  //       // bitcoinValueInUSD = data.toStringAsFixed(0);
  //       x = data.toStringAsFixed(0);
  //       return x;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  void getData() async {
    //7: Second, we set it to true when we initiate the request for prices.
    isWaiting = true;
    try {
      //6: Update this method to receive a Map containing the crypto:price key value pairs.
      var data = await CoinData().getCoinData(selectedCurrency);
      //7. Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    // coinData.getCoinData();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 PeoCoins'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         '1 BTC = $bitcoinValueInUSD $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // currencyButton('ETH'),
          // currencyButton('LTC'),

          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Container(
          //         child: Text(
          //           'Change Style',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             fontSize: 20.0,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          CryptoCard(
            cryptoCurrency: 'BTC',
            //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
            value: isWaiting ? '?' : coinValues['BTC'],
            selectedCurrency: selectedCurrency,
          ),
          CryptoCard(
            cryptoCurrency: 'ETH',
            value: isWaiting ? '?' : coinValues['ETH'],
            selectedCurrency: selectedCurrency,
          ),
          CryptoCard(
            cryptoCurrency: 'LTC',
            value: isWaiting ? '?' : coinValues['LTC'],
            selectedCurrency: selectedCurrency,
          ),



          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // child: Platform.isAndroid ? getDropdownbutton() : iOSPicker(),
              child: iOSPicker(),
          ),
        ],
      ),
    );
  }
}

// String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=D58366A3-CBEF-48B2-83CA-FDC4AA63AF28';
class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}