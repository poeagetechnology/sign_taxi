class SavedLocationModel {
  final String locationId;
  final String userId;
  final String name; // e.g., "Home", "Work", "Gym"
  final double latitude;
  final double longitude;
  final String address;
  final DateTime createdAt;

  SavedLocationModel({
    required this.locationId,
    required this.userId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
  });
}