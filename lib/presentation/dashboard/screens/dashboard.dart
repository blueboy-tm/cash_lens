import 'package:cash_lens/logic/dashboard/cubit/dashboard_cubit.dart';
import 'package:cash_lens/presentation/base/widgets/empty_list.dart';
import 'package:cash_lens/presentation/base/widgets/loading.dart';
import 'package:cash_lens/presentation/dashboard/widgets/account_balances.dart';
import 'package:cash_lens/presentation/dashboard/widgets/incomes_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DashboardCubit>().reload();
        },
        child: SizedBox(
          height: double.infinity,
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (!state.accountsLoaded) {
                return const Center(child: Loading());
              }
              if (state.accountsLoaded && (state.account?.isEmpty ?? true)) {
                return const Center(
                  child: EmptyList('ابتدا یک حساب شخصی اضافه کنید'),
                );
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      IncomesView(state: state),
                      const SizedBox(height: 30),
                      AccountBalances(
                        accounts: state.account!,
                        balances: state.balances!,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
