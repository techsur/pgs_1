import 'package:flutter/material.dart';

class UserProfileHeader extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? profileImageUrl;
  final int notificationCount;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const UserProfileHeader({
    super.key,
    required this.userName,
    required this.userEmail,
    this.profileImageUrl,
    this.notificationCount = 0,
    this.onProfileTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Avatar
          GestureDetector(
            onTap: onProfileTap,
            child: Stack(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.blue[50],
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!) as ImageProvider
                        : null,
                    child: profileImageUrl == null
                        ? const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue,
                    )
                        : null,
                  ),
                ),

                // Online Status Indicator
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),

                // User Stats
                Row(
                  children: [
                    _buildStatItem(Icons.star, '4.8', 'Rating'),
                    const SizedBox(width: 20),
                    _buildStatItem(Icons.book, '12', 'Courses'),
                    const SizedBox(width: 20),
                    _buildStatItem(Icons.emoji_events, '3', 'Badges'),
                  ],
                ),
              ],
            ),
          ),

          // Notification Bell with Badge
          Stack(
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: const Icon(
                  Icons.notifications_none,
                  size: 28,
                  color: Colors.grey,
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notificationCount > 9 ? '9+' : '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}