//import 'package:flutter/material.dart';
//import '../models/banner_model.dart';

import 'dart:async'; // Add this line for Timer
import 'package:flutter/material.dart';
import '../models/banner_model.dart';

class AutoSliderBanner extends StatefulWidget {
  final List<BannerModel> banners;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;

  const AutoSliderBanner({
    super.key,
    required this.banners,
    this.height = 180,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
  });

  @override
  State<AutoSliderBanner> createState() => _AutoSliderBannerState();
}

class _AutoSliderBannerState extends State<AutoSliderBanner> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);

    if (widget.autoPlay && widget.banners.length > 1) {
      _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
        if (_currentPage < widget.banners.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (widget.autoPlay) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return _buildBannerItem(banner);
            },
          ),
        ),

        const SizedBox(height: 15),

        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: _currentPage == index ? 25.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentPage == index
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBannerItem(BannerModel banner) {
    return GestureDetector(
      onTap: () {
        // Handle banner tap
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: banner.backgroundColor ?? const Color(0xFF4A6572),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(banner.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tag (if exists)
              if (banner.tag != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    banner.tag!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

              // Title and Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: banner.textColor ?? Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 3,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    banner.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: banner.textColor ?? Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Price section (if exists)
              if (banner.originalPrice != null || banner.discountedPrice != null)
                Row(
                  children: [
                    if (banner.originalPrice != null)
                      Text(
                        banner.originalPrice!,
                        style: TextStyle(
                          fontSize: 16,
                          color: (banner.textColor ?? Colors.white).withOpacity(0.7),
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    if (banner.discountedPrice != null) ...[
                      const SizedBox(width: 10),
                      Text(
                        banner.discountedPrice!,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: banner.textColor ?? Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),

              // Button (if exists)
              if (banner.buttonText != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      banner.buttonText!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}