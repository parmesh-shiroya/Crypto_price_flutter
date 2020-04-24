import 'package:coin_dcx/data/MarketRepository.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  MarketRepository get marketRepository {
    return new MarketRepository();
  }
}
