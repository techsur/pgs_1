import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Prime Global Studies';
  static const String appTagline = 'Premium Education Platform';

  // Menu Items
  static final List<Map<String, dynamic>> menuItems = [
    {'title': 'All Courses', 'icon': Icons.menu_book, 'color': Colors.blue},
    {'title': 'Live Class', 'icon': Icons.live_tv, 'color': Colors.green},
    {'title': 'Notes', 'icon': Icons.note, 'color': Colors.orange},
    {'title': 'My Paid Courses', 'icon': Icons.payment, 'color': Colors.purple},
    {'title': 'Social Links', 'icon': Icons.share, 'color': Colors.pink},
    {'title': 'Test', 'icon': Icons.assignment, 'color': Colors.red},
    {'title': 'Free Videos', 'icon': Icons.videocam, 'color': Colors.teal},
    {'title': 'Free Test', 'icon': Icons.quiz, 'color': Colors.indigo},
    {'title': 'Store', 'icon': Icons.store, 'color': Colors.amber},
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