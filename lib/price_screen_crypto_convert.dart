import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreenCryptoConvert extends StatefulWidget {
  const PriceScreenCryptoConvert({
    Key? key,
    required this.currency,
    required this.crypto,
  }) : super(key: key);

  final String currency;
  final String crypto;

  @override
  PriceScreenCryptoConvertState createState() =>
      PriceScreenCryptoConvertState();
}

@override
class PriceScreenCryptoConvertState extends State<PriceScreenCryptoConvert> {
  String currentRate = '?';

  void getRate() async {
    try {
      double rate = await CoinData()
          .getCoinData(crypto: widget.crypto, currency: widget.currency);
      setState(() => currentRate = rate.toStringAsFixed(2));
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${widget.crypto} = $currentRate ${widget.currency}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
