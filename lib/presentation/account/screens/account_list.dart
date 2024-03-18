import 'package:cash_lens/logic/account/bloc/account_bloc.dart';
import 'package:cash_lens/presentation/base/widgets/balance_view.dart';
import 'package:cash_lens/presentation/base/widgets/empty_list.dart';
import 'package:cash_lens/presentation/base/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({super.key});

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  final scrollController = ScrollController();
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حساب ها'),
        actions: [
          IconButton(
            onPressed: () =>
                context.pushNamed('addAccount', extra: search.text),
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is! AccountList) {
            return const Loading();
          }
          if (state.accounts.isEmpty) {
            return const EmptyList('هیچ حسابی یافت نشد!');
          }
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<AccountBloc>()
                  .add(AccountListEvent(search: search.text));
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
                          context
                              .read<AccountBloc>()
                              .add(AccountListEvent(search: search.text));
                        },
                        decoration: const InputDecoration(
                          labelText: 'جستجو...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: state.accounts.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final sum = state.sum[index];
                          return InkWell(
                            onTap: () => context.pushNamed(
                              'transactions',
                              extra: state.accounts[index],
                              pathParameters: {
                                'id': state.accounts[index].id.toString()
                              },
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      state.accounts[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () => context.pushNamed(
                                        'editAccount',
                                        extra: [
                                          search.text,
                                          state.accounts[index],
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        fixedSize: const Size(35, 35),
                                        maximumSize: const Size(35, 35),
                                        minimumSize: const Size(35, 35),
                                      ),
                                      child: const Icon(Icons.edit, size: 20),
                                    ),
                                  ],
                                ),
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
                                      sum,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
