import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/transaction/bloc/transaction_bloc.dart';
import 'package:cash_lens/logic/transaction/transaction_queries.dart';
import 'package:cash_lens/presentation/base/widgets/balance_view.dart';
import 'package:cash_lens/presentation/base/widgets/empty_list.dart';
import 'package:cash_lens/presentation/base/widgets/loading.dart';
import 'package:cash_lens/presentation/transaction/widgets/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({
    super.key,
    required this.id,
    this.account,
  });

  final int id;
  final AccountData? account;

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final scrollController = ScrollController();
  final search = TextEditingController();
  late final TransactionQueries queries = TransactionQueries(
    search: search.text,
    account: widget.id,
  );

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(
          TransactionListEvent(queries: queries),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تراکنش ها'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(
              'transferBalance',
              pathParameters: {
                'id': widget.id.toString(),
              },
              extra: queries,
            ),
            icon: const Icon(Icons.reply),
          ),
          IconButton(
            onPressed: () => context.pushNamed(
              'addUserTransaction',
              pathParameters: {
                'id': widget.id.toString(),
              },
              extra: queries,
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        buildWhen: (previous, current) {
          if (previous is TransactionList &&
              current is TransactionList &&
              scrollController.hasClients) {
            Future.delayed(const Duration(milliseconds: 200)).then(
              (value) => scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              ),
            );
          }
          return true;
        },
        builder: (context, state) {
          if (state is! TransactionList) {
            return const Loading();
          }
          if (state.transactions.isEmpty) {
            return const EmptyList('هیچ تراکنشی یافت نشد!');
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TransactionBloc>().add(
                    TransactionListEvent(queries: queries),
                  );
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: search,
                        onEditingComplete: () {
                          queries.search = search.text;
                          queries.page = 1;
                          context.read<TransactionBloc>().add(
                                TransactionListEvent(
                                  queries: queries,
                                ),
                              );
                        },
                        decoration: const InputDecoration(
                          labelText: 'جستجو...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.sizeOf(context).height - 250,
                        ),
                        child: ListView.separated(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            final txn = state.transactions[index];
                            return InkWell(
                              onTap: () => context.pushNamed(
                                'editTransaction',
                                extra: [txn, queries],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        txn.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'باقی‌مانده: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          BalanceView(
                                            txn.balance + txn.amount,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      BalanceView(
                                        txn.amount,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(intl.DateFormat(
                                    intl.DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                                  ).format(txn.date)),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                      PaginationWidget(
                        total: (state.count / 50).ceil(),
                        initial: queries.page,
                        onPageChanged: (page) {
                          queries.page = page;
                          context.read<TransactionBloc>().add(
                                TransactionListEvent(queries: queries),
                              );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
