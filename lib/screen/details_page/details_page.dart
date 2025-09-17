import 'package:flutter/material.dart';
import 'package:assignment_ahmedabad/utils/colors.dart';
import 'package:assignment_ahmedabad/utils/custom_widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../full_screen_page/full_screen_image_page.dart';
import '../full_screen_page/full_screen_video_page.dart';
import 'package:video_player/video_player.dart';
import 'widgets/stat_item.dart';
import 'widgets/vertical_thumbnails.dart';
import 'widgets/title_location_fav.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String location;
  final double rating;
  final String? image;

  const DetailsPage({
    super.key,
    required this.title,
    required this.location,
    required this.rating,
    this.image,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _slideAnim;
  late String _selectedImage;
  bool _isVideoSelected = false;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.image ?? "assets/png/desc.png";

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  void _onThumbnailTap(String img) {
    final bool isVideo = img.endsWith('.mp4');
    setState(() {
      _isVideoSelected = isVideo;
      _selectedImage = img;
    });
    if (isVideo) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.asset(img)
        ..initialize().then((_) {
          setState(() {});
          _videoController?.play();
          _videoController?.setLooping(true);
        });
    } else {
      _videoController?.dispose();
      _videoController = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _opacityAnim.value,
          child: SlideTransition(position: _slideAnim, child: child),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Top image with thumbnails
              SizedBox(
                height: size.height * 0.50,
                child: Stack(
                  children: [
                    if (_isVideoSelected)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        child: _videoController?.value.isInitialized == true
                            ? Stack(
                          fit: StackFit.expand,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoController!.value.size.width,
                                height: _videoController!.value.size.height,
                                child: VideoPlayer(_videoController!),
                              ),
                            ),
                            Container(color: Colors.black26),
                          ],
                        )
                            : const Center(child: CircularProgressIndicator()),
                      )
                    else
                      Hero(
                        tag: _selectedImage,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                            image: DecorationImage(
                              image: AssetImage(_selectedImage),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 18,
                                spreadRadius: 2,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                        ),
                      ),

                    Positioned(
                      top: 35,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff3d7286),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 22,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff3d7286),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (_isVideoSelected) {
                              _videoController?.pause();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FullScreenVideoPage(assetPath: _selectedImage),
                                ),
                              ).then((_) {
                                // Resume inline video when coming back
                                if (mounted && _isVideoSelected) {
                                  _videoController?.play();
                                }
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FullScreenImagePage(image: _selectedImage),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.fullscreen,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 27,
                      left: 50,
                      child: VerticalThumbnails(
                        height: size.height * 0.45,
                        images: [
                          "assets/svg/160342-820741249_small.mp4",
                          "assets/png/desc.png",
                          "assets/png/Recommended_places.png",
                          "assets/png/Recommended_places2.png",
                          "assets/png/Recommended_places4.png",
                        ],
                        selectedImage: _selectedImage,
                        onTap: _onThumbnailTap,
                      ),

                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              /// Title + location + fav
              TitleLocationFav(title: widget.title, location: widget.location),
              const SizedBox(height: 25),

              /// Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    StatItem(
                      icon: Icons.star,
                      iconColor: AppColors.primary,
                      label: 'Rating',
                      value: '${widget.rating} (3.2k)',
                    ),
                    StatItem(
                      icon: Icons.route,
                      iconColor: const Color(0xFF4ECDC4),
                      label: 'Distance',
                      value: '3000 km',
                    ),
                    StatItem(
                      icon: Icons.restaurant,
                      iconColor: const Color(0xFF45B7D1),
                      label: 'Restaurants',
                      value: '108 avail.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /// Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Est vel odio elementum non id venenatis. Enim augue velit '
                      'tristique eu viverra. Massa.',
                  style: GoogleFonts.montserrat(fontSize: 16, height: 1.6),
                ),
              ),
              const SizedBox(height: 30),

              /// Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomButton(),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
