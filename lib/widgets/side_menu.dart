import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? profileImageUrl;
  final VoidCallback? onProfileTap;
  final Function(String)? onMenuItemTap;

  const SideMenu({
    super.key,
    required this.userName,
    required this.userEmail,
    this.profileImageUrl,
    this.onProfileTap,
    this.onMenuItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Profile Header
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onProfileTap,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!) as ImageProvider
                        : null,
                    child: profileImageUrl == null
                        ? const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          ..._buildMenuItems(),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    final menuItems = [
      {'icon': Icons.home, 'title': 'Home', 'hasBadge': false},
      {'icon': Icons.shopping_cart, 'title': 'Purchases', 'hasBadge': false},
      {'icon': Icons.settings, 'title': 'Settings', 'hasBadge': false},
      {'icon': Icons.chat, 'title': 'Chat', 'hasBadge': true, 'badgeCount': 2},
      {'icon': Icons.star, 'title': 'Rate', 'hasBadge': false},
      {'icon': Icons.share, 'title': 'Share/Refer', 'hasBadge': false},
      {'icon': Icons.description, 'title': 'Terms & Conditions', 'hasBadge': false},
      {'icon': Icons.logout, 'title': 'Logout', 'hasBadge': false, 'color': Colors.red},
    ];

    return menuItems.map((item) {
      return ListTile(
        leading: Icon(
          item['icon'] as IconData,
          color: item['color'] as Color? ?? Colors.grey[700],
        ),
        title: Text(
          item['title'] as String,
          style: TextStyle(
            color: item['color'] as Color? ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: (item['hasBadge'] as bool && item['badgeCount'] != null)
            ? Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${item['badgeCount']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : null,
        onTap: () => onMenuItemTap?.call(item['title'] as String),
      );
    }).toList();
  }
}