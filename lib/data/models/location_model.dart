class LocationModel {
  final double latitude;
  final double longitude;
  final String address;
  final String? placeId;
  final String? name;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
    this.placeId,
    this.name,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      placeId: json['placeId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'placeId': placeId,
      'name': name,
    };
  }
}