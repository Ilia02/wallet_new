import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_new/features/presentation/main/bloc/bybit/bybit_auth/bybit_auth_bloc.dart';
import 'package:wallet_new/features/presentation/main/widgets/arrow_back_widget.dart';

class BybitSettingsPage extends StatefulWidget {
  const BybitSettingsPage({super.key});

  @override
  State<BybitSettingsPage> createState() => _BybitSettingsPageState();
}

class _BybitSettingsPageState extends State<BybitSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController apiKeyController = TextEditingController();
    final TextEditingController apiSecretController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        leading: ButtonArrowBackWidget(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: apiKeyController,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: apiSecretController,
              decoration: const InputDecoration(
                labelText: 'API Secret',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            BlocListener<BybitAuthBloc, BybitAuthState>(
              listener: (context, state) {
                if (state is BybitAuthLoggedIn) {
                  context.go("/settings");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Хорошо")),
                  );
                } else if (state is BybitAuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ошибка")),
                  );
                }
              },
              child: BlocBuilder<BybitAuthBloc, BybitAuthState>(
                builder: (context, state) {
                  if (state is BybitAuthInitial) {
                    return ElevatedButton(
                      onPressed: () {
                        String apiKey = apiKeyController.text;
                        String apiSecret = apiSecretController.text;

                        if (apiKey.isNotEmpty && apiSecret.isNotEmpty) {
                          print('API Key: $apiKey, API Secret: $apiSecret');

                          context.read<BybitAuthBloc>().add(
                                BybitSignInEvent(apiKey, apiSecret),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Не заполнены данные")),
                          );
                        }
                      },
                      child: const Text("Сохранить"),
                    );
                  } else if (state is BybitAuthLoading) {
                    return ElevatedButton(
                      onPressed: () {},
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox.shrink(); // Возвращаем пустой виджет
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
