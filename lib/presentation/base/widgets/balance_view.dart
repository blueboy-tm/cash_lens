import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class BalanceView extends StatelessWidget {
  const BalanceView(this.balance, {super.key, this.style});
  final double balance;
  final TextStyle? style;
  Color? get color {
    if (balance == 0) {
      return null;
    } else if (balance > 0) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String get sign {
    if (balance == 0) {
      return '';
    } else if (balance > 0) {
      return '+';
    } else {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      sign +
          intl.NumberFormat.decimalPattern('en').format(
            balance.abs(),
          ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      style: style != null
          ? style!.copyWith(color: color)
          : TextStyle(color: color),
    );
  }
}
