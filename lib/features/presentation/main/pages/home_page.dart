import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/get_coin/get_coin_bybit_cubit.dart';
import 'package:wallet_new/features/presentation/main/widgets/button_notifications_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Wallet Balance",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "\$6641.20",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text("Monthly Profit",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "\$1850.00",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  DropdownMenuWidget(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "+13%",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({
    super.key,
  });

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  String? selectedValue = 'USD';
  final List<String> items = ['USD', 'EUR', 'RUB'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.orange),
      iconSize: 24,
      dropdownColor: Colors.white,
      isExpanded: false,
      underline: const SizedBox(),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
    );
  }
}
