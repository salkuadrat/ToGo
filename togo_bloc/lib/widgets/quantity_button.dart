import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';

class QuantityButton extends StatelessWidget {
  final int quantity;
  final Function(int quantity)? onChanged;

  const QuantityButton(
    this.quantity, {
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElegantNumberButton(
      initialValue: quantity,
      minValue: 0,
      maxValue: 9999999,
      decimalPlaces: 0,
      buttonSizeWidth: 30,
      buttonSizeHeight: 30,
      onChanged: (value) => onChanged?.call(value.toInt()),
    );
  }
}
