import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget ButtonNotificationsWidget(BuildContext context) {
  return IconButton(
    icon: Container(
      margin: const EdgeInsets.only(right: 12),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    ),
    onPressed: () => context.go("/settings"),
  );
}
