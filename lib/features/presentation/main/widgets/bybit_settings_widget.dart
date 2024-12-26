import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/bybit_auth/bybit_auth_bloc.dart';

class BybitSettingsWidget extends StatefulWidget {
  BybitSettingsWidget(BuildContext context,
      {required this.loggedIn, super.key});

  bool loggedIn = false;

  @override
  State<BybitSettingsWidget> createState() => _BybitSettingsWidgetState();
}

class _BybitSettingsWidgetState extends State<BybitSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.loggedIn
        ? Card(
            elevation: 3,
            child: ListTile(
              title: const Text('Bybit'),
              subtitle: const Text('Настройки API ключей'),
              trailing: const Icon(Icons.close),
              onTap: () {
                context.read<BybitAuthBloc>().add(BybitSignOutEvent());
              },
            ),
          )
        : Card(
            elevation: 3,
            child: ListTile(
              title: const Text('Bybit'),
              subtitle: const Text('Настройки API ключей'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                context.go("/bybit");
              },
            ),
          );
  }
}
