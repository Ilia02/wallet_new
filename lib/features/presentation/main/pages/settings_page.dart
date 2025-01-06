import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/bybit_auth/bybit_auth_bloc.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            ToggleTheme(context),
            const SizedBox(height: 16),
            BlocBuilder<BybitAuthBloc, BybitAuthState>(
              builder: (context, state) {
                if (state is BybitAuthLoggedIn) {
                  return BybitSettingsWidget(context, loggedIn: true);
                } else {
                  return BybitSettingsWidget(context, loggedIn: false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
