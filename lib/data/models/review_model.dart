class ReviewModel {
  final String reviewId;
  final String rideId;
  final String reviewerId; // user who gave review
  final String receiverId; // driver who received review
  final double rating; // 1-5
  final String? reviewText;
  final List<String> tags; // e.g., ["safe", "clean", "polite"]
  final String? photoUrl;
  final DateTime createdAt;

  ReviewModel({
    required this.reviewId,
    required this.rideId,
    required this.reviewerId,
    required this.receiverId,
    required this.rating,
    this.reviewText,
    this.tags = const [],
    this.photoUrl,
    required this.createdAt,
  });
}