import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AddAccountEvent>(_addAccount);
    on<EditAccountEvent>(_updateAccount);
    on<DeleteAccountEvent>(_deleteAccount);
    on<AccountListEvent>(_accountList);
  }

  _addAccount(AddAccountEvent event, Emitter<AccountState> emit) async {
    final id = await Database.instance.addAccount(
      title: event.title,
      description: event.description,
      createdDate: event.createdDate,
      personal: event.personal,
    );
    emit(AccountObjectSuccess(id: id));
  }

  _updateAccount(EditAccountEvent event, Emitter<AccountState> emit) async {
    final success = await Database.instance.updateAccount(
      event.id,
      title: event.title,
      description: event.description,
      createdDate: event.createdDate,
      personal: event.personal,
    );
    if (success) {
      emit(AccountObjectSuccess(id: event.id));
    } else {
      emit(AccountObjectError());
    }
  }

  _deleteAccount(DeleteAccountEvent event, Emitter<AccountState> emit) async {
    final id = await Database.instance.deleteAccount(event.id);
    emit(DeleteAccountSuccess(id: id));
  }

  _accountList(AccountListEvent event, Emitter<AccountState> emit) async {
    final accounts = await Database.instance.accountList(event.search ?? '');
    final sum = <double>[];
    for (final account in accounts) {
      sum.add(
        await Database.instance.transactionSum(account: account.id),
      );
    }
    emit(AccountList(accounts: accounts, sum: sum));
  }
}
