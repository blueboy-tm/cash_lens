import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({
    super.key,
    required this.onChanged,
    this.value,
    this.hideToggleButtons = false,
  });
  final Function(double value) onChanged;
  final double? value;
  final bool hideToggleButtons;

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  late final amount = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
    initialValue: widget.value != null
        ? widget.value! < 0
            ? widget.value! * -1
            : widget.value!
        : 0.0,
  );
  late bool negative = widget.value != null ? widget.value! < 0 : false;

  toggleNegative() {
    setState(() {
      negative = !negative;
    });
    callOnChanged();
  }

  callOnChanged() {
    if (negative) {
      widget.onChanged.call(amount.numberValue * -1);
    } else {
      widget.onChanged.call(amount.numberValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == '0.00') {
              return 'مبلغ باید بیشتر از صفر باشد.';
            }
            return null;
          },
          controller: amount,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            callOnChanged();
          },
          decoration: const InputDecoration(
            labelText: 'مبلغ',
          ),
        ),
        if (!widget.hideToggleButtons) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: !negative ? null : toggleNegative,
                style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder(),
                  elevation: 0,
                ),
                child: const Text('واریز'),
              ),
              ElevatedButton(
                onPressed: negative ? null : toggleNegative,
                style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder(),
                  elevation: 0,
                ),
                child: const Text('برداشت'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
