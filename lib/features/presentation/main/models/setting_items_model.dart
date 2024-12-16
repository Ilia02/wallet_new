import 'package:flutter/material.dart';

class SettingItemsModel {
  final Icon? icon;
  final String description;
  final String? label;
  final IconButton? iconButton;
  final Switch? buttonSwitch;

  SettingItemsModel(
      {required this.icon,
      required this.description,
      required this.label,
      required this.iconButton,
      required this.buttonSwitch});
}

List<SettingItemsModel> getSettingItems = [
  SettingItemsModel(
    icon: const Icon(Icons.wb_sunny_rounded),
    description: "Night Theme",
    label: null,
    iconButton: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_forward_ios_rounded),
    ),
    buttonSwitch: Switch(
      value: false,
      onChanged: (bool value) {
        // TODO: Добавьте обработчик для изменения темы
        print("Night Theme: $value");
      },
    ),
  ),
  SettingItemsModel(
    icon: null,
    description: "Bybit",
    label: null,
    iconButton: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_forward_ios_rounded),
    ),
    buttonSwitch: null,
  ),
];
