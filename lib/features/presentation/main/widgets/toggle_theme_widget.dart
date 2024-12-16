import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_new/core/services/theme_cubit.dart';

class ToggleTheme extends StatefulWidget {
  const ToggleTheme(BuildContext context, {super.key});

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: const Text("Theme"),
        leading: const Icon(Icons.wb_sunny_rounded),
        subtitle: Text(switchValue ? 'Night' : 'Light'),
        trailing: Switch(
          value: switchValue,
          onChanged: (bool value) {
            setState(() {
              switchValue = value;
            });
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ),
    );
  }
}
