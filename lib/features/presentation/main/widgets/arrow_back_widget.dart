import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget ButtonArrowBackWidget(BuildContext context) {
  return IconButton(
    icon: Container(
      margin: const EdgeInsets.only(left: 12),
      width: 72,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.arrow_back),
    ),
    onPressed: () => context.go("/"),
  );
}
