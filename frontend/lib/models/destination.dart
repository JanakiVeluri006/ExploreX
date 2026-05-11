class Destination {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final String category;
  final double rating;
  bool isFavorite;

  Destination({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.category,
    required this.rating,
    this.isFavorite = false,
  });
}