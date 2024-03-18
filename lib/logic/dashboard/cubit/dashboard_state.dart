part of 'dashboard_cubit.dart';

class DashboardState {
  final bool accountsLoaded;
  final List<AccountData>? account;
  final List<double>? balances;
  final IncomeCost? day;
  final IncomeCost? month;
  final IncomeCost? year;
  final IncomeCost? all;

  DashboardState({
    this.accountsLoaded = false,
    this.account,
    this.balances,
    this.day,
    this.month,
    this.year,
    this.all,
  });

  copyWith({
    bool? accountsLoaded,
    List<AccountData>? account,
    List<double>? balances,
    IncomeCost? day,
    IncomeCost? month,
    IncomeCost? year,
    IncomeCost? all,
  }) {
    return DashboardState(
      accountsLoaded: accountsLoaded ?? this.accountsLoaded,
      account: account ?? this.account,
      balances: balances ?? this.balances,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      all: all ?? this.all,
    );
  }
}
