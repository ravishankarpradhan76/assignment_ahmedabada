import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment_ahmedabad/utils/colors.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const StatItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 44,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 24),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: AppColors.LowEmphasized,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.HighEmphasized,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
