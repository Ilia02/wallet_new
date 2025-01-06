import 'dart:ui';
import 'package:flutter/material.dart';

class AddCoinDialog extends StatefulWidget {
  @override
  _AddCoinDialogState createState() => _AddCoinDialogState();
}

class _AddCoinDialogState extends State<AddCoinDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCoin;
  List<String> _filteredCoins = [];
  final List<String> _allCoins = [
    'Bitcoin',
    'Ethereum',
    'Tether',
    'Binance Coin',
    'Cardano',
    'Ripple',
    'Solana',
    'Polkadot',
    'Dogecoin',
    'Litecoin',
  ];

  DateTime? _selectedDate;
  double? _rate;
  int? _quantity;

  @override
  void initState() {
    super.initState();
    _filteredCoins = _allCoins.take(5).toList(); // Отображаем первые 5
  }

  void _filterCoins(String query) {
    setState(() {
      _filteredCoins = _allCoins
          .where((coin) => coin.toLowerCase().contains(query.toLowerCase()))
          .take(5)
          .toList();
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.of(context).pop({
        'coinName': _selectedCoin,
        'date': _selectedDate,
        'rate': _rate,
        'quantity': _quantity,
      });
    }
  }

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),
        Center(
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Add Coin',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    _buildCoinSelector(),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Rate',
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _rate = double.tryParse(value ?? ''),
                      validator: (value) =>
                          (double.tryParse(value ?? '') == null)
                              ? 'Enter valid rate'
                              : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Quantity',
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _quantity = int.tryParse(value ?? ''),
                      validator: (value) => (int.tryParse(value ?? '') == null)
                          ? 'Enter valid quantity'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: _submitForm, child: const Text('Add Coin')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoinSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Coin Name',
            border: OutlineInputBorder(),
          ),
          onChanged: _filterCoins,
        ),
        const SizedBox(height: 8),
        Container(
          height: 150, // Ограничение высоты для списка
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListView.builder(
            itemCount: _filteredCoins.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredCoins[index]),
                onTap: () {
                  setState(() {
                    _selectedCoin = _filteredCoins[index];
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Selected: ${_filteredCoins[index]}')),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType? keyboardType,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDate,
      child: InputDecorator(
        decoration: const InputDecoration(labelText: 'Date'),
        child: Text(
          _selectedDate?.toLocal().toString().split(' ')[0] ?? 'Select Date',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
