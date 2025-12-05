class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final double rating;
  final int students;
  final String price;
  final String originalPrice;
  final String imageUrl;
  final bool isPaid;
  final String category;
  final int totalVideos;
  final int totalTests;
  final String duration;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.rating,
    required this.students,
    required this.price,
    this.originalPrice = '',
    required this.imageUrl,
    required this.isPaid,
    this.category = 'General',
    this.totalVideos = 0,
    this.totalTests = 0,
    this.duration = '0 hours',
  });

  bool get hasDiscount => originalPrice.isNotEmpty && originalPrice != price;
}