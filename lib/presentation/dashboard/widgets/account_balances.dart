import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/presentation/base/widgets/balance_view.dart';
import 'package:flutter/material.dart';

class AccountBalances extends StatelessWidget {
  const AccountBalances(
      {super.key, required this.accounts, required this.balances});
  final List<AccountData> accounts;
  final List<double> balances;

  Widget item(BuildContext context, String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        BalanceView(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(
            width: 4,
            color: Color.fromRGBO(192, 209, 84, 1),
          ),
        ),
        color: const Color.fromRGBO(236, 239, 242, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, size: 26),
              Text(
                'حساب ها',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          ...List.generate(
            accounts.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              child: item(context, accounts[index].title, balances[index]),
            ),
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          item(
            context,
            'جمع کل',
            balances.fold(
                0, (previousValue, element) => previousValue + element),
          ),
        ],
      ),
    );
  }
}
