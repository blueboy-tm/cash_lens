import 'package:cash_lens/logic/account/bloc/account_bloc.dart';
import 'package:cash_lens/presentation/account/widgets/form.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key, required this.search});
  final String? search;
  static const String title = 'افزودن حساب';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountObjectSuccess) {
            ElegantNotification.success(
              title: const Text(title),
              description: const Text('حساب با موفقیت ایجاد شد.'),
            ).show(context);
            context.read<AccountBloc>().add(AccountListEvent(search: search));
            context.pop();
          } else if (state is AccountObjectError) {
            ElegantNotification.error(
              title: const Text(title),
              description: const Text('ایجاد حساب با خطا مواجه شد.'),
            ).show(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: AccountForm(
              initialValue: null,
              onFormSubmit: (value) {
                context.read<AccountBloc>().add(
                      AddAccountEvent(
                        title: value.title.value,
                        description: value.description.value,
                        createdDate: value.createdDate.value,
                        personal: value.personal.value,
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
