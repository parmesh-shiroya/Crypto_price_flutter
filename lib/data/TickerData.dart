class TickerData {
  String market;
  double change24Hour;
  String high;
  String low;
  String volume;
  String lastPrice;
  String bid;
  String ask;
  int timestamp;

  TickerData(
      {this.market,
      this.change24Hour,
      this.high,
      this.low,
      this.volume,
      this.lastPrice,
      this.bid,
      this.ask,
      this.timestamp});

  TickerData.fromJson(Map<String, dynamic> json) {
    market = json['market'];
    try {
      change24Hour = double.parse (double.parse(json['change_24_hour'].toString()).toStringAsFixed(2));
    }catch(e){
      change24Hour = 0.0;
    }
    high = json['high'];
    low = json['low'];
    volume = json['volume'];
    lastPrice = json['last_price'];

    bid = json['bid'].toString();
    ask = json['ask'].toString();
    timestamp = json['timestamp'];
  }
}
