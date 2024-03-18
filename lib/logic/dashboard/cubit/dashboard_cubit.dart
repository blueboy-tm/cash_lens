import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/dashboard/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  void reload() async {
    final date = DateTime.now();
    final accounts = await Database.instance.personalAccounts();

    final balances = <double>[];
    for (final account in accounts) {
      balances.add(await Database.instance.transactionSum(account: account.id));
    }
    emit(state.copyWith(
      account: accounts,
      balances: balances,
      accountsLoaded: true,
    ));
    emit(state.copyWith(
      day: await Database.instance.incomeCost(
        accounts: accounts,
        from: DateTime(date.year, date.month, date.day, 0, 0, 0),
        to: DateTime(date.year, date.month, date.day, 23, 59, 59),
      ),
      month: await Database.instance.incomeCost(
        accounts: accounts,
        from: DateTime(date.year, date.month, 1, 0, 0, 0),
        to: DateTime(date.year, date.month,
            DateTime(date.year, date.month + 1, 0).day, 23, 59, 59),
      ),
      year: await Database.instance.incomeCost(
        accounts: accounts,
        from: DateTime(date.year, 1),
        to: DateTime(date.year, 12),
      ),
      all: await Database.instance.incomeCost(
        accounts: accounts,
      ),
    ));
  }
}
