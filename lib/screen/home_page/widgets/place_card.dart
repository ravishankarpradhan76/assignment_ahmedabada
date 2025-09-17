import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../details_page/details_page.dart';

class PlaceCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final double rating;

  const PlaceCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              image: image,
              title: title,
              location: location,
              rating: rating,
            ),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth == double.infinity
              ? screenWidth * 0.65
              : constraints.maxWidth;

          return Container(
            width: cardWidth,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
              border: Border.all(width: 1, color: AppColors.borderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            image,
                            height: screenWidth * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black26,
                          child: Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w400,
                              color: AppColors.HighEmphasized,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: AppColors.orangeColor,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                location,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth * 0.032,
                                  color: AppColors.LowEmphasized,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, size: 18, color: AppColors.primary),
                          const SizedBox(width: 2.0),
                          Text(
                            rating.toString(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w300,
                              color: AppColors.MidEmphasized,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
