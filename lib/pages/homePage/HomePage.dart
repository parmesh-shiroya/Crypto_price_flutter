import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:coin_dcx/data/MarketData.dart';
import 'package:coin_dcx/data/TickerData.dart';
import 'package:coin_dcx/pages/homePage/components/BottomSheetContent.dart';
import 'package:coin_dcx/pages/homePage/components/ChangePercentBadge.dart';
import 'package:coin_dcx/presenters/MarketListPresenter.dart';
import 'package:coin_dcx/presenters/TickerListPresenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SORT_TYPE {
  NONE,
  ASC,
  DESC,
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements MarketListViewContract, TickerListViewContract {
  MarketListPresenter _marketListPresenter;
  TickerListPresenter _tickerListPresenter;

  Map<String, TickerData> _tickerData;
  List<String> _tabs = List();
  Map<String, List<MarketData>> _marketByTargetCurrency = Map();
  bool errorWhileFetching ;
  SORT_TYPE _coinNameSort = SORT_TYPE.NONE;
  SORT_TYPE _hourChangeSort = SORT_TYPE.NONE;

  _HomePageState() {
    _marketListPresenter = new MarketListPresenter(this);
    _tickerListPresenter = new TickerListPresenter(this);
  }

  String _sortingImage(SORT_TYPE st) {
    switch (st) {
      case SORT_TYPE.ASC:
        return "images/ic_asc.png";
      case SORT_TYPE.DESC:
        return "images/ic_desc.png";
      case SORT_TYPE.NONE:
        return "images/ic_asc_desc.png";
    }
  }

  @override
  void initState() {
    super.initState();
    _marketListPresenter.loadMarketDetail();
    _tickerListPresenter.loadTicker();
  }

  void _divideMarketList(List<MarketData> items) {
    _marketByTargetCurrency.clear();
    _marketByTargetCurrency["ALL"] = items;
    items.forEach((f) => {
          if (!_marketByTargetCurrency.containsKey(f.baseCurrencyShortName))
            {_marketByTargetCurrency[f.baseCurrencyShortName] = List()},
          _marketByTargetCurrency[f.baseCurrencyShortName].add(f)
        });
    setState(() {});
  }

  void _sortByName() {
    var _mList = _marketByTargetCurrency["ALL"];
    if (_coinNameSort == SORT_TYPE.NONE) {
      _mList.sort((a, b) => a.targetCurrencyShortName
          .toLowerCase()
          .compareTo(b.targetCurrencyShortName.toLowerCase()));
    } else
      _mList = _mList.reversed.toList();

    _coinNameSort =
        (_coinNameSort == SORT_TYPE.ASC) ? SORT_TYPE.DESC : SORT_TYPE.ASC;

    _hourChangeSort = SORT_TYPE.NONE;
    _divideMarketList(_mList);
  }

  void _sortByChange() {
    var _mList = _marketByTargetCurrency["ALL"];
    if (_hourChangeSort == SORT_TYPE.NONE) {
      _mList.sort((a, b) => _tickerData[a.coindcxName]
          .change24Hour
          .compareTo(_tickerData[b.coindcxName].change24Hour));
    } else
      _mList = _mList.reversed.toList();

    _hourChangeSort =
        (_hourChangeSort == SORT_TYPE.ASC) ? SORT_TYPE.DESC : SORT_TYPE.ASC;
    _coinNameSort = SORT_TYPE.NONE;

    _divideMarketList(_mList);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          centerTitle: true,
          title: Text(
            "MARKETS",
            style: TextStyle(fontSize: 17),
          ),
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            isScrollable: true,
            tabs: _tabs.map((f) => Tab(text: f)).toList(),
            indicatorSize: TabBarIndicatorSize.label,
            indicator: new BubbleTabIndicator(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 5),
              indicatorColor: const Color(0xFF293658),
              tabBarIndicatorSize: TabBarIndicatorSize.label,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(width: 1, color: const Color(0xFF293658))),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: _sortByName,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "COIN NAME",
                          style: TextStyle(color: const Color(0xFF68779C)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          _sortingImage(_coinNameSort),
                          height: 13,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _sortByChange,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "24h Change",
                          style: TextStyle(color: const Color(0xFF68779C)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                           _sortingImage(_hourChangeSort),
                          height: 13,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(errorWhileFetching ==true)
              Expanded(child: Center(child: Text("Error while fetching data"),),)
        else      if (_tickerData != null && _tabs.length > 0)
              Expanded(
                child: TabBarView(
                  children: _tabs
                      .map(
                        (f) => ListView.builder(
                          itemCount: _marketByTargetCurrency[f].length,
                          itemBuilder: (BuildContext context, int index) =>
                              _getRow(index, f, context),
                        ),
                      )
                      .toList(),
                ),
              )
            else
              Expanded(
                child: Center(child: CircularProgressIndicator(),),
              )
          ],
        ),
      ),
    );
  }

  @override
  void onLoadErrorSuccess() {
// TODO:   Show the error in some interactive way
    Fluttertoast.showToast(msg: "Error while fetching data");
    setState(() {
      errorWhileFetching = true;
    });
  }

  @override
  void onLoadMarketSuccess(List<MarketData> items) {
    _tabs.clear();
    _tabs.add("ALL");

    _marketByTargetCurrency.clear();
    _marketByTargetCurrency["ALL"] = items;
    items.forEach((f) => {
          if (_tabs != null && !_tabs.contains(f.baseCurrencyShortName))
            {
              _tabs.add(f.baseCurrencyShortName),
              _marketByTargetCurrency[f.baseCurrencyShortName] = List()
            },
          _marketByTargetCurrency[f.baseCurrencyShortName].add(f)
        });
    setState(() {

    });
  }

  @override
  void onLoadTickerSuccess(Map<String, TickerData> items) {
    setState(() {
      _tickerData = items;
    });
  }

  Widget _getRow(int i, String targetCurrency, BuildContext c) {
    var _currency = _marketByTargetCurrency[targetCurrency][i];
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: c,
            isScrollControlled: true,
            backgroundColor: const Color(0xFF0D111D),
            builder: (context) => BottomSheetContent(
                _currency, _tickerData[_currency.coindcxName]));
      },
      child: new Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: const Color(0xFF293658))),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: SvgPicture.network(
                          "https://coindcx.com/assets/coins/${_currency.targetCurrencyShortName}.svg"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: _currency.targetCurrencyShortName,
                                style: TextStyle(fontSize: 14)),
                            TextSpan(
                                text: " / " + _currency.baseCurrencyShortName,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: const Color(0xFF99AAD5))),
                          ]),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: _tickerData[_currency.coindcxName]
                                        .lastPrice
                                        .toString() +
                                    " " +
                                    _currency.baseCurrencyShortName,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xFF68779C))),
//                          TextSpan(
//
//                              text: "  "+_tickerData[_marketDetailList[i].coindcxName].change24Hour,
//                              style: TextStyle(
//                                  fontSize: 12, color: const Color(0xFF515A70)))
                          ]),
                        )
                      ],
                    )
                  ],
                ),
                ChangePercentBadge(
                    _tickerData[_currency.coindcxName].change24Hour)
              ],
            ),
          )),
    );
  }
}
