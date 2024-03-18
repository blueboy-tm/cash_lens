import 'package:cash_lens/logic/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';

class IncomesView extends StatelessWidget {
  const IncomesView({super.key, required this.state});
  final DashboardState state;

  Widget title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF8F8F8F),
      ),
    );
  }

  Widget item(double income, double cost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          income.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        Text(
          cost.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.red,
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
            color: Color.fromRGBO(84, 185, 209, 1),
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
              Icon(Icons.attach_money, size: 26),
              Text(
                'درآمد و هزینه',
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
          title('امروز'),
          const SizedBox(height: 5),
          item(state.day?.income ?? 0, state.day?.cost ?? 0),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          title('این ماه'),
          const SizedBox(height: 5),
          item(state.month?.income ?? 0, state.month?.cost ?? 0),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          title('امسال'),
          const SizedBox(height: 5),
          item(state.year?.income ?? 0, state.year?.cost ?? 0),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          title('کل'),
          const SizedBox(height: 5),
          item(state.all?.income ?? 0, state.all?.cost ?? 0),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
