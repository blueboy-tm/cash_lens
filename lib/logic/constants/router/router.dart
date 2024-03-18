import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/transaction/transaction_queries.dart';
import 'package:cash_lens/presentation/account/screens/add_account.dart';
import 'package:cash_lens/presentation/account/screens/edit_account.dart';
import 'package:cash_lens/presentation/base/widgets/base.dart';
import 'package:cash_lens/presentation/transaction/screens/add_transaction.dart';
import 'package:cash_lens/presentation/transaction/screens/edit_transaction.dart';
import 'package:cash_lens/presentation/transaction/screens/transaction_list.dart';
import 'package:cash_lens/presentation/transaction/screens/transfer_balance.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: 'root',
    builder: (context, state) => const BaseScreen(),
  ),
  GoRoute(
    path: '/account/add',
    name: 'addAccount',
    builder: (context, state) =>
        AddAccountScreen(search: state.extra as String?),
  ),
  GoRoute(
    path: '/account/edit',
    name: 'editAccount',
    builder: (context, state) {
      final [search, account] = state.extra as List;
      return EditAccountScreen(
        search: search,
        account: account,
      );
    },
  ),
  GoRoute(
    path: '/transactions/:id',
    name: 'transactions',
    builder: (context, state) {
      return TransactionListScreen(
        id: int.parse(state.pathParameters['id']!),
        account: state.extra as AccountData?,
      );
    },
  ),
  GoRoute(
    path: '/transaction/add/:id',
    name: 'addUserTransaction',
    builder: (context, state) {
      return AddTransactionScreen(
        account: int.parse(state.pathParameters['id']!),
        queries: state.extra as TransactionQueries,
      );
    },
  ),
  GoRoute(
    path: '/transaction/edit',
    name: 'editTransaction',
    builder: (context, state) {
      final [txn, queries] = state.extra as List;
      return EditTransactionScreen(
        transaction: txn,
        queries: queries,
      );
    },
  ),
  GoRoute(
    path: '/transfer/:id',
    name: 'transferBalance',
    builder: (context, state) {
      return TransferBalance(
        account: int.parse(state.pathParameters['id']!),
        queries: state.extra as TransactionQueries,
      );
    },
  ),
]);
