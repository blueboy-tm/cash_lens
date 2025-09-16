import 'package:cash_lens/logic/account/bloc/account_bloc.dart';
import 'package:cash_lens/logic/dashboard/cubit/dashboard_cubit.dart';
import 'package:cash_lens/presentation/account/screens/account_list.dart';
import 'package:cash_lens/presentation/dashboard/screens/dashboard.dart';
import 'package:cash_lens/presentation/settings/screens/settings.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final pageController = PageController();
  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        page = pageController.page?.toInt() ?? page;
      });
    });
    context.read<AccountBloc>().add(AccountListEvent());
    context.read<DashboardCubit>().reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          DashboardScreen(),
          AccountListScreen(),
          SettingsScreen(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: page,
        selectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
        backgroundColor: Colors.black.withValues(alpha: 0.05),
        onTap: (index) {
          if (index == 0) {
            context.read<DashboardCubit>().reload();
          }
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        },
        items: [
          CrystalNavigationBarItem(
            icon: Icons.bar_chart,
          ),
          CrystalNavigationBarItem(
            icon: Icons.groups,
          ),
          CrystalNavigationBarItem(
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
