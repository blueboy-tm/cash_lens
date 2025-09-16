import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/constants/form/validators/text_input.dart';
import 'package:cash_lens/presentation/account/widgets/account_input.dart';
import 'package:cash_lens/presentation/base/widgets/date_picker.dart';
import 'package:cash_lens/presentation/transaction/widgets/amount_input.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.initialValue,
    required this.onFormSubmit,
    this.onDelete,
    required this.label,
    this.account,
  });
  final TxnData? initialValue;
  final int? account;
  final Function(TxnCompanion value) onFormSubmit;
  final Function()? onDelete;
  final Widget label;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  late final title = TextEditingController(text: widget.initialValue?.title);
  late final description = TextEditingController(
    text: widget.initialValue?.description,
  );
  late DateTime date = widget.initialValue?.date ?? DateTime.now();

  late double amount = widget.initialValue?.amount ?? 0;

  final formKey = GlobalKey<FormState>();

  Future<List<AccountData>> searchAccount(String query) async {
    return await Database.instance.accountList(query);
  }

  late int? account = widget.account ?? widget.initialValue?.account;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: title,
            validator: TextInputValidator(
              minLength: 3,
              maxLength: 32,
            ).validator,
            decoration: const InputDecoration(
              labelText: 'عنوان',
            ),
          ),
          const SizedBox(height: 15),
          AccountInput(
            onChanged: (value) {
              account = value?.id;
            },
            value: account,
            hintText: 'حساب مرتبط',
          ),
          const SizedBox(height: 15),
          AmountInput(
            onChanged: (value) => amount = value,
            value: amount,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: description,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'توضیحات',
            ),
          ),
          const SizedBox(height: 15),
          DatePicker(
            value: date,
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
            labelText: 'تاریخ',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  widget.onFormSubmit.call(TxnCompanion.insert(
                    title: title.text,
                    amount: drift.Value(amount),
                    account: account!,
                    balance:
                        drift.Value.absentIfNull(widget.initialValue?.balance),
                    description: description.text,
                    date: drift.Value.absentIfNull(date),
                  ));
                },
                child: widget.label,
              ),
              const SizedBox(width: 10),
              if (widget.onDelete != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 251, 103, 103),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // TODO: create a new dialog
                    widget.onDelete?.call();
                    // CoolAlert.show(
                    //   context: context,
                    //   type: CoolAlertType.confirm,
                    //   cancelBtnText: 'بستن',
                    //   confirmBtnText: 'حذف',
                    //   title: 'از حذف تراکنش مطمعن هستید؟',
                    //   titleTextStyle: const TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    //   onConfirmBtnTap: () => widget.onDelete?.call(),
                    // );
                  },
                  child: const Text(
                    'حذف',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
