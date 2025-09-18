import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../details_page/widgets/vertical_thumbnails.dart';
import 'full_screen_video_page.dart';

class FullScreenImagePage extends StatefulWidget {
  final String image;

  const FullScreenImagePage({super.key, required this.image});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: _selectedImage,
            child: Image.asset(
              _selectedImage,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 75,
            left: 50,
            child:  VerticalThumbnails(
              height: size.height * 0.45,
              images: [
                "assets/svg/160342-820741249_small.mp4",
                "assets/png/desc.png",
                "assets/png/Recommended_places.png",
                "assets/png/Recommended_places2.png",
                "assets/png/Recommended_places4.png",
              ],
              selectedImage: _selectedImage,
              onTap: (img) {
                if (img.endsWith('.mp4')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenVideoPage(assetPath: img),
                    ),
                  );
                } else {
                  setState(() => _selectedImage = img);
                }
              },
              selectedSize: 90,
              unselectedSize: 75,
            ),

          ),

          Positioned(
            top: 42,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff3d7286),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.fullscreen_exit, color: AppColors.whiteColor, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),)
        ],
      ),
    );
  }
}
