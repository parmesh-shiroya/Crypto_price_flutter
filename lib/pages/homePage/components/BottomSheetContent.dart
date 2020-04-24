import 'package:coin_dcx/data/MarketData.dart';
import 'package:coin_dcx/data/TickerData.dart';
import 'package:coin_dcx/pages/homePage/components/ChangePercentBadge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class BottomSheetContent extends StatelessWidget {
  MarketData _marketData;
  TickerData _ticketData;

  BottomSheetContent(this._marketData, this._ticketData);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Container(
            color: const Color(0xFF1E2A4A),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  child: SvgPicture.network(
                      "https://coindcx.com/assets/coins/${_marketData.targetCurrencyShortName}.svg"),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  _marketData.targetCurrencyName+" Coin",
                  style:
                  TextStyle(color: const Color(0xFF99AAD5), fontSize: 16),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "(${_marketData.coindcxName})",
                  style:
                  TextStyle(color: const Color(0xFF68779C), fontSize: 14),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: const Color(0xFF293658))),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("LAST TRADE PRICE",
                        style: TextStyle(
                            fontSize: 11, color: const Color(0xFF68779C))),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${double.parse(_ticketData.lastPrice) }  ${_marketData.baseCurrencyShortName}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                ChangePercentBadge(_ticketData.change24Hour)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: labelValueWidget("24H HIGH", "\u20B9 "+ _ticketData.high),

                ),
                Expanded(
                  flex: 1,
                  child: labelValueWidget("24H LOW",  "\u20B9 "+_ticketData.low),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget labelValueWidget(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: TextStyle(fontSize: 11, color: const Color(0xFF68779C))),
        SizedBox(
          height: 3,
        ),
        Text(
          value,
          style: TextStyle(color: const Color(0xFF99AAD5)),
        )
      ],
    );
  }
}
