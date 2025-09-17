import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(14),
        child: SvgPicture.asset(
          'assets/svg/Menu.svg',
          width: 26,
          height: 17,
          color: AppColors.grey,
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/Location icon.svg',
            width: 20,
            height: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            'Dhaka, Bangladesh',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColors.LowEmphasized,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            height: 44,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: BoxBorder.all(width: 5, color: Color(0xffffffff)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/png/profile.png'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
