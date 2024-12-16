import 'package:flutter/material.dart';

class NavItemsModel {
  final Icon icon;
  final String page;

  NavItemsModel({required this.icon, required this.page});
}

List<NavItemsModel> bottomNavItems = [
  NavItemsModel(icon: const Icon(Icons.home), page: '/'),
  NavItemsModel(icon: const Icon(Icons.account_circle), page: '/profile'),
  NavItemsModel(icon: const Icon(Icons.settings), page: '/settings'),
];
