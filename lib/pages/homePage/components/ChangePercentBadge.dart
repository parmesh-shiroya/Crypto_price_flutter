import 'package:flutter/material.dart';
class ChangePercentBadge extends StatelessWidget {
 final double _change24Hour;

  ChangePercentBadge(this._change24Hour);
  @override
  Widget build(BuildContext context) {
    var alpha =_change24Hour
        .abs()
        .toInt() *30;
    return Container(
      width: 78,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color:
          (_change24Hour < 0)
              ? Colors.red.withAlpha(
              alpha > 255 ? 255 : alpha )
              : Colors.green.withAlpha(
              alpha > 255 ? 255 : alpha)),
      child: Text(
        _change24Hour.toString()+"%",
        textAlign: TextAlign.center,
      ),
    );
  }
}
