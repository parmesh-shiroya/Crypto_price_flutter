import 'package:coin_dcx/Injector.dart';
import 'package:coin_dcx/data/MarketRepository.dart';
import 'package:coin_dcx/data/TickerData.dart';

abstract class TickerListViewContract {
  void onLoadTickerSuccess(Map<String, TickerData> items);
  void onLoadErrorSuccess();
}

class TickerListPresenter {
  TickerListViewContract _view;
  MarketRepository _repository;

  TickerListPresenter(this._view) {
    _repository = new Injector().marketRepository;
  }

  void loadTicker() {
    _repository
        .fetchTicker()
        .then((c) => _view.onLoadTickerSuccess(c))
        .catchError((onError) => _view.onLoadErrorSuccess());
  }
}
