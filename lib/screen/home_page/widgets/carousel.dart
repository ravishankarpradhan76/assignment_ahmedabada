import 'package:assignment_ahmedabad/screen/details_page/details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/colors.dart';

class SwipeableCardsDemo extends StatefulWidget {
  const SwipeableCardsDemo({super.key});

  @override
  State<SwipeableCardsDemo> createState() => _SwipeableCardsDemoState();
}

class _SwipeableCardsDemoState extends State<SwipeableCardsDemo>
    with SingleTickerProviderStateMixin {
  final List<String> assetImages = [
    'assets/png/Recommended_places.png',
    'assets/png/Recommended_places2.png',
    'assets/png/Recommended_places3.png',
    'assets/png/Recommended_places.png',
    'assets/png/Recommended_places2.png',
    'assets/png/Recommended_places2.png',
    'assets/png/Recommended_places3.png',
    'assets/png/Recommended_places.png',
    'assets/png/Recommended_places2.png',
    'assets/png/Recommended_places.png',
  ];

  int topCardIndex = 0;
  Offset cardOffset = Offset.zero;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_animationController);
  }

  void swipeCard(Offset offset) {
    if (_animationController.isAnimating) return;

    _slideAnimation = Tween<Offset>(begin: cardOffset, end: offset).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    void listener() {
      setState(() {
        cardOffset = _slideAnimation.value;
      });
    }

    _slideAnimation.addListener(listener);

    _animationController.forward().then((_) {
      _slideAnimation.removeListener(listener);
      setState(() {
        topCardIndex = (topCardIndex + 1) % assetImages.length;
        cardOffset = Offset.zero; // Reset position after swipe
        _animationController.reset();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = 280;
    int n = assetImages.length;

    return SizedBox(
      height: cardHeight + 70,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          ...assetImages
              .asMap()
              .entries
              .map((entry) {
                int index = entry.key;
                String url = entry.value;

                // safe modulo so result is always 0..n-1
                int position = (index - topCardIndex + n) % n;
                if (position > 3) return const SizedBox.shrink();

                double offsetY = position * 16.0;
                double shadow = 4 + position * 4;
                bool isTopCard = position == 0;

                // while animating we already update cardOffset via listener,
                // so currentOffset just reads cardOffset for top card
                Offset currentOffset = isTopCard ? cardOffset : Offset.zero;

                // Only shrink non-top cards
                double scale = isTopCard ? 1.0 : (1.0 - (position * 0.07));
                double cardWidth = isTopCard
                    ? screenWidth - 40
                    : (screenWidth - 40) * scale;

                return Positioned(
                  key: ValueKey('$url-$index-$topCardIndex'),
                  top: offsetY + currentOffset.dy,
                  child: Transform.translate(
                    offset: Offset(currentOffset.dx, 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: cardWidth,
                      height: cardHeight,
                      child: GestureDetector(
                        onPanUpdate:
                            isTopCard && !_animationController.isAnimating
                            ? (details) {
                                setState(() {
                                  cardOffset += details.delta;
                                });
                              }
                            : null,
                        onPanEnd: isTopCard && !_animationController.isAnimating
                            ? (details) {
                                double threshold = 100;
                                if (cardOffset.dx > threshold) {
                                  swipeCard(Offset(screenWidth, 0));
                                } else if (cardOffset.dx < -threshold) {
                                  swipeCard(Offset(-screenWidth, 0));
                                } else if (cardOffset.dy < -threshold) {
                                  swipeCard(Offset(0, -screenWidth));
                                } else if (cardOffset.dy > threshold) {
                                  swipeCard(Offset(0, screenWidth));
                                } else {
                                  setState(() {
                                    cardOffset = Offset.zero;
                                  });
                                }
                              }
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsPage(
                                image: url,
                                title: 'Nusa Pedina',
                                location: 'Bali, Indonesia',
                                rating: 2.1,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: shadow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              image: DecorationImage(
                                image: AssetImage(url),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Landmannalaugar",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "Fjallabak, Iceland",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
              .toList()
              .reversed
              .toList(),

          /// Dot Indicator
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(assetImages.length, (index) {
                bool isActive = index == topCardIndex;
                if (isActive) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade400,
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
