part of 'transaction_bloc.dart';

sealed class TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final String title;
  final int account;
  final double amount;
  final String description;
  final DateTime? date;

  AddTransactionEvent({
    required this.title,
    required this.account,
    required this.amount,
    required this.description,
    required this.date,
  });
}

class TransferBalanceEvent extends TransactionEvent {
  final String title;
  final int from;
  final int to;
  final double amount;
  final String description;
  final DateTime? date;

  TransferBalanceEvent({
    required this.title,
    required this.from,
    required this.to,
    required this.amount,
    required this.description,
    required this.date,
  });
}

class EditTransactionEvent extends TransactionEvent {
  final int id;
  final String? title;
  final int? account;
  final double? amount;
  final double? balance;
  final String? description;
  final DateTime? date;

  EditTransactionEvent({
    required this.id,
    this.title,
    this.account,
    this.amount,
    this.balance,
    this.description,
    this.date,
  });
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;

  DeleteTransactionEvent({required this.id});
}

class TransactionListEvent extends TransactionEvent {
  final TransactionQueries queries;
  TransactionListEvent({required this.queries});
}
