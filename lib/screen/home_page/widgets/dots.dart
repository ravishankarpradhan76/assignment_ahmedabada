import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class DotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DotsIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 15 : 10,
          height: currentIndex == index ? 15 : 10,
          decoration: BoxDecoration(
            color: currentIndex == index ? AppColors.primary : Colors.white38,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
