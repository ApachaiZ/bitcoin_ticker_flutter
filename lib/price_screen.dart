import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/price_screen_crypto_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String selectedValue = (currenciesList.isNotEmpty) ? currenciesList[0] : '?';
  String selectedCrypto = (cryptoList.isNotEmpty) ? cryptoList[0] : '?';

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) =>
          setState(() => selectedValue = currenciesList[selectedIndex]),
      children: pickerItems,
    );
  }

  DropdownButton<String> androidPicker() {
    //Declaring a empty List which will contain my Items
    List<DropdownMenuItem<String>> dropDownItems = [];
    //Looping through the currenciesList and adding each value to dropDownItems
    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          value: currency,
          child: Text(
            currency,
          ),
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedValue,
      items: dropDownItems,
      onChanged: (value) => setState(() => selectedValue = value as String),
    );
  }

  List<Widget> getCryptoConverted() {
    List<Widget> myCryptoList = [];
    for (String crypto in cryptoList) {
      myCryptoList.add(
        PriceScreenCryptoConvert(
          crypto: crypto,
          currency: selectedValue,
        ),
      );
    }
    return (myCryptoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...getCryptoConverted(),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //Choose either iOS picker or Android DropDown depending on platform
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
