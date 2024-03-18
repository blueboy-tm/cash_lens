part of 'account_bloc.dart';

sealed class AccountState {}

final class AccountInitial extends AccountState {}

class AccountObjectSuccess extends AccountState {
  final int id;

  AccountObjectSuccess({required this.id});
}

class DeleteAccountSuccess extends AccountState {
  final int id;

  DeleteAccountSuccess({required this.id});
}

class AccountObjectError extends AccountState {}

class AccountList extends AccountState {
  final List<AccountData> accounts;
  final List<double> sum;

  AccountList({required this.accounts, required this.sum});
}
