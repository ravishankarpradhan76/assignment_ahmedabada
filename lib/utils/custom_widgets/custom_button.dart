import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height *0.07,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Book A Trip',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.background,
          ),
        ),
      ),
    );
  }
}
