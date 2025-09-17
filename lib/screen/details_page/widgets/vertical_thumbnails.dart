import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalThumbnails extends StatelessWidget {
  final double height;
  final List<String> images;
  final String selectedImage;
  final Function(String) onTap;

  /// ✅ Thumbnail size configurable
  final double selectedSize;
  final double unselectedSize;

  const VerticalThumbnails({
    super.key,
    required this.height,
    required this.images,
    required this.selectedImage,
    required this.onTap,
    this.selectedSize = 65, // default for DetailsPage
    this.unselectedSize = 55, // default for DetailsPage
  });

  @override
  Widget build(BuildContext context) {
    final items = List.generate(images.length, (index) {
      final isSelected = images[index] == selectedImage;

      final size = isSelected ? selectedSize : unselectedSize;

      if (index == images.length - 1) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70, width: 5),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              "10+",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () => onTap(images[index]),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70, width: 5),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: index == 0
                ? Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.black87,
                  size: 22,
                ),
              ),
            )
                : null,
          ),
        );
      }
    });

    return Column(mainAxisSize: MainAxisSize.min, children: items);
  }
}
