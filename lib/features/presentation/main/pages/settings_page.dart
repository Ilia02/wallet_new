import 'package:flutter/material.dart';
import 'package:wallet_new/features/presentation/main/widgets/arrow_back_widget.dart';
import 'package:wallet_new/features/presentation/main/widgets/bybit_settings_widget.dart';
import 'package:wallet_new/features/presentation/main/widgets/toggle_theme_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        leading: ButtonArrowBackWidget(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            ToggleTheme(context),
            const SizedBox(height: 16),
            BybitSettingsWidget(context),
          ],
        ),
      ),
    );
  }
}
