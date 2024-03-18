import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/transaction/transaction_queries.dart';
import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<AddTransactionEvent>(_addTransaction);
    on<TransferBalanceEvent>(_transferBalance);
    on<EditTransactionEvent>(_updateTransaction);
    on<DeleteTransactionEvent>(_deleteTransaction);
    on<TransactionListEvent>(_transactionList);
  }

  _transferBalance(
    TransferBalanceEvent event,
    Emitter<TransactionState> emit,
  ) async {
    await Database.instance.addTransaction(
      title: event.title,
      account: event.from,
      amount: event.amount.abs() * -1,
      description: event.description,
      date: event.date,
    );
    final id = await Database.instance.addTransaction(
      title: event.title,
      account: event.to,
      amount: event.amount.abs(),
      description: event.description,
      date: event.date,
    );
    emit(TransactionObjectSuccess(id: id));
  }

  _addTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final id = await Database.instance.addTransaction(
      title: event.title,
      account: event.account,
      amount: event.amount,
      description: event.description,
      date: event.date,
    );
    emit(TransactionObjectSuccess(id: id));
  }

  _updateTransaction(
    EditTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final success = await Database.instance.updateTransaction(
      event.id,
      title: event.title,
      account: event.account,
      amount: event.amount,
      balance: event.balance,
      description: event.description,
      date: event.date,
    );
    if (success) {
      final txnList = Database.instance.select(Database.instance.txn)
        ..where(
          (tbl) =>
              tbl.date.isBiggerThanValue(event.date!) &
              tbl.account.equals(event.account!),
        );
      double previusBalance = event.amount! + event.balance!;
      for (final txn in await txnList.get()) {
        await Database.instance.updateTransaction(
          txn.id,
          title: txn.title,
          account: txn.account,
          amount: txn.amount,
          balance: previusBalance,
          description: txn.description,
          date: txn.date,
        );
        previusBalance += txn.amount;
      }
      emit(TransactionObjectSuccess(id: event.id));
    } else {
      emit(TransactionObjectError());
    }
  }

  _deleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final id = await Database.instance.deleteTransaction(event.id);
    emit(DeleteTransactionSuccess(id: id));
  }

  _transactionList(
    TransactionListEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      TransactionList(
        transactions: await Database.instance.transactionList(
          search: event.queries.search ?? '',
          account: event.queries.account,
          page: event.queries.page,
        ),
        count: await Database.instance.transactionCount(
          search: event.queries.search ?? '',
          account: event.queries.account,
        ),
      ),
    );
  }
}
