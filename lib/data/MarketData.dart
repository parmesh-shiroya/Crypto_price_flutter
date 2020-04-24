class MarketData {
  String coindcxName;
  String baseCurrencyShortName;
  String targetCurrencyShortName;
  String targetCurrencyName;
  String baseCurrencyName;
  double minQuantity;
  double maxQuantity;
  double minPrice;
  double maxPrice;
  double minNotional;
  int baseCurrencyPrecision;
  int targetCurrencyPrecision;
  double step;
  List<String> orderTypes;
  String symbol;
  String ecode;
  double maxLeverage;
  double maxLeverageShort;
  String pair;
  String status;

  MarketData(
      {this.coindcxName,
      this.baseCurrencyShortName,
      this.targetCurrencyShortName,
      this.targetCurrencyName,
      this.baseCurrencyName,
      this.minQuantity,
      this.maxQuantity,
      this.minPrice,
      this.maxPrice,
      this.minNotional,
      this.baseCurrencyPrecision,
      this.targetCurrencyPrecision,
      this.step,
      this.orderTypes,
      this.symbol,
      this.ecode,
      this.maxLeverage,
      this.maxLeverageShort,
      this.pair,
      this.status});

  MarketData.fromJson(Map<String, dynamic> json) {
    coindcxName = json['coindcx_name'];
    baseCurrencyShortName = json['base_currency_short_name'];
    targetCurrencyShortName = json['target_currency_short_name'];
    targetCurrencyName = json['target_currency_name'];
    baseCurrencyName = json['base_currency_name'];
    minQuantity = json['min_quantity'];
    maxQuantity = json['max_quantity'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    minNotional = json['min_notional'];
    baseCurrencyPrecision = json['base_currency_precision'];
    targetCurrencyPrecision = json['target_currency_precision'];
    step = json['step'];
    orderTypes = json['order_types'].cast<String>();
    symbol = json['symbol'];
    ecode = json['ecode'];
    maxLeverage = json['max_leverage'];
    maxLeverageShort = json['max_leverage_short'];
    pair = json['pair'];
    status = json['status'];
  }
}
