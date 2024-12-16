import 'package:flutter/material.dart';
import 'package:wallet_new/features/presentation/main/widgets/arrow_back_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 84,
        leading: ButtonArrowBackWidget(context),
        title: const Text("Profile"),
        centerTitle: true,
      ),
    );
  }
}
