import 'package:flutter/material.dart';
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
            ElevatedButton(
              onPressed: () {
                // Логика сохранения ключей
                String apiKey = apiKeyController.text;
                String apiSecret = apiSecretController.text;
                print('API Key: $apiKey, API Secret: $apiSecret');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ключи сохранены!')),
                );
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
