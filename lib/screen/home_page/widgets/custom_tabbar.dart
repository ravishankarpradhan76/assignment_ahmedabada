import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> tabs = [
    {"icon": "assets/svg/Group.svg", "label": "Popular"},
    {"icon": "assets/svg/Chips icons.svg", "label": "Lake"},
    {"icon": "assets/svg/Chips icons (1).svg", "label": "Beach"},
    {"icon": "assets/svg/Chips icons (2).svg", "label": "Mountain"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final tab = tabs[index];

          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AnimatedContainer(
                height: 55,
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: isSelected
                        ? AppColors.tabBarBorderColor
                        : Color(0xffd6d6d6),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.tabBarBorderColor.withOpacity(0.4),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        tab["icon"],
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? AppColors.whiteColor
                              : AppColors.LowEmphasized,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tab["label"],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.whiteColor
                              : AppColors.LowEmphasized,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
