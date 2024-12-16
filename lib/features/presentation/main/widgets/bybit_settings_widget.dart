import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BybitSettingsWidget extends StatefulWidget {
  const BybitSettingsWidget(BuildContext context, {super.key});

  @override
  State<BybitSettingsWidget> createState() => _BybitSettingsWidgetState();
}

class _BybitSettingsWidgetState extends State<BybitSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
