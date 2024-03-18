import 'package:cash_lens/logic/account/bloc/account_bloc.dart';
import 'package:cash_lens/logic/constants/database/database.dart';
import 'package:cash_lens/logic/constants/router/router.dart';
import 'package:cash_lens/logic/dashboard/cubit/dashboard_cubit.dart';
import 'package:cash_lens/logic/transaction/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

void main(List<String> arguments) {
  intl.Intl.defaultLocale = 'fa';
  WidgetsFlutterBinding.ensureInitialized();
  Database.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => TransactionBloc()),
        BlocProvider(create: (context) => DashboardCubit()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cash Lens',
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('fa'),
      supportedLocales: const [
        Locale('fa'),
        Locale('tr'),
      ],
      theme: ThemeData(
        fontFamily: 'Estedad',
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFBF0DF),
          tertiary: const Color(0xFFB8581F),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 3,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
