import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment_ahmedabad/utils/colors.dart';

class TitleLocationFav extends StatelessWidget {
  final String title;
  final String location;

  const TitleLocationFav({
    super.key,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.w400,
                    color: AppColors.HighEmphasized,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: AppColors.orangeColor, size: 18),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        location,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: AppColors.MidEmphasized,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 33,
            width: 33,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.extraLightOrangeColor,
            ),
            child: Center(
              child: Icon(
                Icons.favorite,
                color: AppColors.primary,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
