
import 'package:assignment_ahmedabad/screen/home_page/widgets/carousel.dart';
import 'package:assignment_ahmedabad/screen/home_page/widgets/custom_tabbar.dart';
import 'package:assignment_ahmedabad/screen/home_page/widgets/place_card.dart';
import 'package:assignment_ahmedabad/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/custom_widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final places = [
      {
        'image': 'assets/png/desc.png',
        'title': 'Nusa Pedina',
        'location': 'Bali, Indonesia',
        'rating': 4.8,
      },
      {
        'image': 'assets/png/Recommended_places3.png',
        'title': 'Nusa Pedina',
        'location': 'Bali, Indonesia',
        'rating': 4.8,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: 16,
              ),
              child: ListView(
                physics: BouncingScrollPhysics(), // allows smooth scroll
                children: [
                  Text(
                    'Hi John,',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w300,
                      color: AppColors.MidEmphasized,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Where do you',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.w700,
                      color: AppColors.HighEmphasized,
                      height: 0,
                    ),
                  ),
                  Text(
                    'wanna go?',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.w700,
                      color: AppColors.HighEmphasized,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    child: SwipeableCardsDemo(), // Now swipe works
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTabBar(),
                  SizedBox(
                    height: screenHeight * 0.29,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: places.length,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          tween: Tween(begin: 0.8, end: 1.0),
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: screenWidth * 0.03,
                                  top: screenHeight * 0.015,
                                  bottom: screenHeight * 0.015,
                                ),
                                child: PlaceCard(
                                  image: place['image'].toString(),
                                  title: place['title'].toString(),
                                  location: place['location'].toString(),
                                  rating: place['rating'] as double,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
    );

  }
}
