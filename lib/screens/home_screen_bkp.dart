import 'package:flutter/material.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/latest_course_card.dart';
import '../models/course.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Course> latestCourses = [
    Course(
      id: '1',
      title: 'Mathematics Masterclass',
      description: 'Complete mathematics course for competitive exams',
      instructor: 'Prof. Ramesh Kumar',
      rating: 4.8,
      students: 2450,
      price: '₹2,999',
      originalPrice: '₹4,999',
      imageUrl: AppConstants.placeholderImage,
      isPaid: true,
      category: 'Mathematics',
      totalVideos: 120,
      totalTests: 15,
      duration: '60 hours',
    ),
    Course(
      id: '2',
      title: 'Science Fundamentals',
      description: 'Basic concepts of Physics & Chemistry',
      instructor: 'Dr. Priya Singh',
      rating: 4.5,
      students: 1800,
      price: 'FREE',
      imageUrl: AppConstants.placeholderImage,
      isPaid: false,
      category: 'Science',
      totalVideos: 80,
      totalTests: 10,
      duration: '40 hours',
    ),
    Course(
      id: '3',
      title: 'History & Geography',
      description: 'Complete course for general studies',
      instructor: 'Prof. Amit Sharma',
      rating: 4.7,
      students: 3200,
      price: '₹1,499',
      originalPrice: '₹2,499',
      imageUrl: AppConstants.placeholderImage,
      isPaid: true,
      category: 'General Studies',
      totalVideos: 60,
      totalTests: 8,
      duration: '30 hours',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'PRIME',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'Global Studies',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menu Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: AppConstants.menuItems.length,
                itemBuilder: (context, index) {
                  final item = AppConstants.menuItems[index];
                  return MenuItemCard(
                    title: item['title'],
                    icon: item['icon'],
                    color: item['color'],
                    onTap: () {
                      _handleMenuItemTap(item['title']);
                    },
                  );
                },
              ),
            ),

            const Divider(),

            // Latest Courses
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Courses',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

            // Teacher Chat Ad
            _buildTeacherChatAd(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: AppConstants.bottomNavItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon']),
            label: item['title'],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTeacherChatAd() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chat with Teachers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get instant doubt solving from expert teachers',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Start Chat'),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
            size: 60,
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

  void _openCourseDetails(Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Instructor: ${course.instructor}'),
            Text('Rating: ${course.rating}'),
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
}