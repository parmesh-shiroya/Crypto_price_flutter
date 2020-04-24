import 'package:coin_dcx/Injector.dart';
import 'package:coin_dcx/data/MarketData.dart';
import 'package:coin_dcx/data/MarketRepository.dart';

abstract class MarketListViewContract {
  void onLoadMarketSuccess(List<MarketData> items);
  void onLoadErrorSuccess();
}

class MarketListPresenter {
  MarketListViewContract _view;
  MarketRepository _repository;

  MarketListPresenter(this._view) {
    _repository = new Injector().marketRepository;
  }

  void loadMarketDetail() {
    _repository
        .fetchMarket()
        .then((c) => _view.onLoadMarketSuccess(c))
        .catchError((onError) => _view.onLoadErrorSuccess());
  }
}
