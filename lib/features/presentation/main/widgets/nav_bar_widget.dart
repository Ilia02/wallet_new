import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_new/features/presentation/main/models/nav_items_model.dart';

class NavBatWidget extends StatefulWidget {
  const NavBatWidget(BuildContext context, {super.key});

  @override
  State<NavBatWidget> createState() => _NavBatWidgetState();
}

class _NavBatWidgetState extends State<NavBatWidget> {
  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 36),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    bottomNavItems.length,
                    (index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(isActive: selectedNavIndex == index),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedNavIndex = index;
                                  context.go(bottomNavItems[index].page);
                                });
                              },
                              //context.go(bottomNavItems[index].page),
                              icon: bottomNavItems[index].icon),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 56,
                width: 56,
                margin: const EdgeInsets.only(right: 36),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
