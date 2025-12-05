import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Prime Global Studies';
  static const String appTagline = 'Premium Education Platform';

  // Main Menu Items
  static final List<Map<String, dynamic>> mainMenuItems = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'Purchases', 'icon': Icons.shopping_cart},
    {'title': 'Settings', 'icon': Icons.settings},
    {'title': 'Share', 'icon': Icons.share},
    {'title': 'Rate', 'icon': Icons.star},
    {'title': 'Chat', 'icon': Icons.chat},
    {'title': 'Terms & Conditions', 'icon': Icons.description},
    {'title': 'Logout', 'icon': Icons.logout},
  ];

  // Bottom Navigation Items
  static final List<Map<String, dynamic>> bottomNavItems = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'My Courses', 'icon': Icons.library_books},
    {'title': 'Downloads', 'icon': Icons.download},
    {'title': 'Notice Board', 'icon': Icons.notifications},
  ];

  // Placeholder image URL
  static const String placeholderImage = 'https://via.placeholder.com/300x200/4A6572/FFFFFF?text=PGS';
}