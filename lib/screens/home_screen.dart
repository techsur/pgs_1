import 'package:flutter/material.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/latest_course_card.dart';
import '../widgets/auto_slider_banner.dart';
import '../widgets/user_profile_header.dart';
import '../widgets/goal_selector.dart';
import '../widgets/side_menu.dart';
import '../models/course.dart';
import '../models/banner_model.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample banners data
  final List<BannerModel> banners = [
    BannerModel(
      id: '1',
      title: 'NEET/JEE PATNA',
      subtitle: 'OFFLINE BATCH',
      imageUrl: 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1',
      tag: 'Popular',
      originalPrice: '₹1,50,000',
      discountedPrice: '₹25,000',
      buttonText: 'Enroll Now',
      backgroundColor: const Color(0xFF4A6572),
    ),
    BannerModel(
      id: '2',
      title: 'UPSC Foundation',
      subtitle: 'Complete GS Package',
      imageUrl: 'https://images.unsplash.com/photo-1501504905252-473c47e087f8',
      tag: 'Limited Offer',
      discountedPrice: '₹49,999',
      buttonText: 'Book Now',
      backgroundColor: const Color(0xFF2E7D32),
    ),
    BannerModel(
      id: '3',
      title: 'Free Crash Course',
      subtitle: '7 Days Free Trial',
      imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3',
      tag: 'Free',
      buttonText: 'Start Free',
      backgroundColor: const Color(0xFF1565C0),
    ),
  ];

  // Sample courses data
  final List<Course> latestCourses = [
    Course(
      id: '1',
      title: 'VISION 250',
      description: 'Complete NEET preparation course',
      instructor: 'Expert Faculty',
      rating: 4.9,
      students: 2500,
      price: '₹25,000',
      originalPrice: '₹50,000',
      imageUrl: 'https://images.unsplash.com/photo-1588072432836-e10032774350',
      isPaid: true,
    ),
    Course(
      id: '2',
      title: 'SALON - Current Affairs',
      description: 'Daily current affairs updates',
      instructor: 'Current Affairs Team',
      rating: 4.7,
      students: 3500,
      price: 'FREE',
      imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71',
      isPaid: false,
    ),
    Course(
      id: '3',
      title: 'JEE Advanced Crash Course',
      description: '45 days intensive program',
      instructor: 'IIT Alumni',
      rating: 4.8,
      students: 1800,
      price: '₹15,000',
      imageUrl: 'https://images.unsplash.com/photo-1606326608606-aa0b62935f2b',
      isPaid: true,
    ),
  ];

  // Quick Access Items
  final List<Map<String, dynamic>> quickAccessItems = [
    {'title': 'All Courses', 'icon': Icons.menu_book, 'color': Colors.blue},
    {'title': 'Live Classes', 'icon': Icons.live_tv, 'color': Colors.purple},
    {'title': 'Recorded Classes', 'icon': Icons.live_tv, 'color': Colors.lime},
    {'title': 'Test Series', 'icon': Icons.assignment, 'color': Colors.green},
    {'title': 'Daily Quiz', 'icon': Icons.quiz, 'color': Colors.indigo},
    {'title': 'Free Classes', 'icon': Icons.videocam, 'color': Colors.pink},
    {'title': 'Notes', 'icon': Icons.newspaper, 'color': Colors.orange},
    {'title': 'Downloads', 'icon': Icons.download, 'color': Colors.red},
    {'title': 'Ask Doubts', 'icon': Icons.help, 'color': Colors.teal},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PRIME',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'Global Studies',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: _searchPressed,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: _notificationsPressed,
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      drawer: SideMenu(
        userName: 'S K',
        userEmail: 'sk@gmail.com',
        profileImageUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
        onProfileTap: _openProfile,
        onMenuItemTap: _handleMenuItemTap,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Goal Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GoalSelector(
                selectedGoal: 'NEET/JEE',
                onGoalChanged: (goal) {
                  print('Goal changed to: $goal');
                },
              ),
            ),

            const SizedBox(height: 20),

            // Auto Slider Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AutoSliderBanner(
                banners: banners,
                height: 180,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
            ),

            const SizedBox(height: 25),

            // Quick Access
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Access',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: quickAccessItems.length,
                    itemBuilder: (context, index) {
                      final item = quickAccessItems[index];
                      return GestureDetector(
                        onTap: () {
                          _handleQuickAccessTap(item['title']);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: item['color'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: item['color'].withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                item['icon'],
                                color: item['color'],
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Recommended Courses
/*            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recommended Courses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: _viewAllCourses,
                        child: const Text(
                          'See All',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: latestCourses.length,
                      itemBuilder: (context, index) {
                        return LatestCourseCard(
                          course: latestCourses[index],
                          onTap: () {
                            _openCourseDetails(latestCourses[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),*/

            const SizedBox(height: 25),

            // Statistics Section
            //_buildStatisticsSection(),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _handleBottomNavTap(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'My Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
        ],
      ),
    );
  }

/*  Widget _buildStatisticsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.people, '5K+', 'Students'),
          _buildStatItem(Icons.play_circle_fill, '500+', 'Videos'),
          _buildStatItem(Icons.assignment, '100+', 'Tests'),
          _buildStatItem(Icons.emoji_events, '95%', 'Success Rate'),
        ],
      ),
    );
  }*/

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Event Handlers
  void _openProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile'),
        content: const Text('Profile page coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleMenuItemTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title tapped'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleQuickAccessTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title tapped'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _searchPressed() {
    // Implement search
  }

  void _notificationsPressed() {
    // Show notifications
  }

  void _viewAllCourses() {
    // Navigate to all courses
  }

  void _openCourseDetails(Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Instructor: ${course.instructor}'),
            Text('Rating: ${course.rating} ⭐'),
            Text('Price: ${course.price}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    // Handle bottom navigation
  }
}