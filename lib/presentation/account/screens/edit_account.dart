import 'package:cash_lens/logic/account/bloc/account_bloc.dart';
import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/presentation/account/widgets/form.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({
    super.key,
    required this.search,
    required this.account,
  });

  final String? search;
  static const String title = 'ویرایش حساب';
  final AccountData account;

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
              description: const Text('حساب با موفقیت ویرایش شد.'),
            ).show(context);
            context.read<AccountBloc>().add(AccountListEvent(search: search));
            context.pop();
          } else if (state is DeleteAccountSuccess) {
            ElegantNotification.error(
              title: const Text('حذف حساب'),
              description: const Text('حساب با موفقیت حذف شد.'),
            ).show(context);
            context.read<AccountBloc>().add(AccountListEvent(search: search));
            context.pop();
          } else if (state is AccountObjectError) {
            ElegantNotification.error(
              title: const Text(title),
              description: const Text('ویرایش حساب با خطا مواجه شد.'),
            ).show(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: AccountForm(
              initialValue: account,
              onFormSubmit: (value) {
                context.read<AccountBloc>().add(
                      EditAccountEvent(
                        id: account.id,
                        title: value.title.value,
                        description: value.description.value,
                        createdDate: value.createdDate.value,
                        personal: value.personal.value,
                      ),
                    );
              },
              label: const Text('ویرایش'),
              onDelete: () {
                context.read<AccountBloc>().add(
                      DeleteAccountEvent(
                        id: account.id,
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
