part of 'transaction_bloc.dart';

sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

class TransactionObjectSuccess extends TransactionState {
  final int id;

  TransactionObjectSuccess({required this.id});
}

class DeleteTransactionSuccess extends TransactionState {
  final int id;

  DeleteTransactionSuccess({required this.id});
}

class TransactionObjectError extends TransactionState {}

class TransactionList extends TransactionState {
  final List<TxnData> transactions;
  final int count;

  TransactionList({required this.transactions, required this.count});
}
