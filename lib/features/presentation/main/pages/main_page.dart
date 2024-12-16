import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/get_coin/get_coin_bybit_cubit.dart';
import 'package:wallet_new/features/presentation/main/pages/home_page.dart';
import 'package:wallet_new/features/presentation/main/widgets/button_notifications_widget.dart';
import 'package:wallet_new/features/presentation/main/widgets/nav_bar_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<GetCoinBybitCubit, GetCoinBybitState>(
            builder: (context, state) {
              if (state is GetCoinBybitInitial || state is CoinLoading) {
                context.read<GetCoinBybitCubit>().fetchCoin("BTCUSDT");
                return const CircularProgressIndicator();
              } else if (state is CoinLoaded) {
                return Text(state.coin.lastPrice.toString());
              } else {
                return const Text("Error");
              }
            },
          ),
          centerTitle: true,
          actions: [
            ButtonNotificationsWidget(context),
          ],
        ),
        body: HomePage(context),
        bottomNavigationBar: NavBatWidget(context));
  }
}
