import 'package:cash_lens/logic/transaction/bloc/transaction_bloc.dart';
import 'package:cash_lens/logic/transaction/transaction_queries.dart';
import 'package:cash_lens/presentation/transaction/widgets/form.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key, this.account, required this.queries});
  static const String title = 'افزودن تراکنش';

  final int? account;
  final TransactionQueries queries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('افزودن تراکنش'),
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionObjectSuccess) {
            ElegantNotification.success(
              title: const Text(title),
              description: const Text('تراکنش با موفقیت ایجاد شد.'),
            ).show(context);
            context
                .read<TransactionBloc>()
                .add(TransactionListEvent(queries: queries));
            context.pop();
          } else if (state is TransactionObjectError) {
            ElegantNotification.error(
              title: const Text(title),
              description: const Text('ایجاد تراکنش با خطا مواجه شد.'),
            ).show(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TransactionForm(
              account: account,
              initialValue: null,
              onFormSubmit: (value) {
                context.read<TransactionBloc>().add(
                      AddTransactionEvent(
                        title: value.title.value,
                        account: value.account.value,
                        amount: value.amount.value,
                        description: value.description.value,
                        date: value.date.value,
                      ),
                    );
              },
              label: const Text('افزودن'),
            ),
          ),
        ),
      ),
    );
  }
}
