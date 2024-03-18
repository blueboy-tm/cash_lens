import 'package:cash_lens/logic/constants/form/validators/text_input.dart';
import 'package:cash_lens/logic/transaction/bloc/transaction_bloc.dart';
import 'package:cash_lens/logic/transaction/transaction_queries.dart';
import 'package:cash_lens/presentation/account/widgets/account_input.dart';
import 'package:cash_lens/presentation/base/widgets/date_picker.dart';
import 'package:cash_lens/presentation/transaction/widgets/amount_input.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TransferBalance extends StatefulWidget {
  const TransferBalance({
    super.key,
    required this.account,
    required this.queries,
  });

  static const String title = 'انتقال وجه';

  final int account;
  final TransactionQueries queries;

  @override
  State<TransferBalance> createState() => _TransferBalanceState();
}

class _TransferBalanceState extends State<TransferBalance> {
  late final title = TextEditingController();
  late final description = TextEditingController();
  late DateTime date = DateTime.now();

  late double amount = 0;

  final formKey = GlobalKey<FormState>();

  late int? from = widget.account;
  int? to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتقال وجه'),
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionObjectSuccess) {
            ElegantNotification.success(
              title: const Text(TransferBalance.title),
              description: const Text('انتقال وجه انجام شد.'),
            ).show(context);
            context
                .read<TransactionBloc>()
                .add(TransactionListEvent(queries: widget.queries));
            context.pop();
          } else if (state is TransactionObjectError) {
            ElegantNotification.error(
              title: const Text(TransferBalance.title),
              description: const Text('انتقال وجه با خطا مواجه شد.'),
            ).show(context);
          }
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                    onChanged: (account) {
                      from = account.id;
                    },
                    value: widget.account,
                    hintText: 'از حساب',
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Icon(
                      Icons.keyboard_double_arrow_down_sharp,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AccountInput(
                    onChanged: (account) {
                      to = account.id;
                    },
                    hintText: 'به حساب',
                  ),
                  const SizedBox(height: 15),
                  AmountInput(
                    onChanged: (value) {
                      amount = value;
                    },
                    hideToggleButtons: true,
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
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      context.read<TransactionBloc>().add(
                            TransferBalanceEvent(
                              title: title.text,
                              from: from!,
                              to: to!,
                              amount: amount,
                              date: date,
                              description: description.text,
                            ),
                          );
                    },
                    child: const Text('انتقال'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
