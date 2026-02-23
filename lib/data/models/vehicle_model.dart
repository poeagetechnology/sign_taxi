// lib/data/models/vehicle_model.dart
class VehicleModel {
  final String vehicleId;
  final String driverId;
  final String registrationNumber;
  final String make;
  final String model;
  final int year;
  final String color;
  final int seatingCapacity;
  final List<String> photoUrls;   // 4 angles
  final String registrationCertUrl;
  final DateTime registrationExpiryDate;
  final String insuranceProvider;
  final String insurancePolicyNumber;
  final DateTime insuranceExpiryDate;
  final String insuranceDocumentUrl;
  final bool acAvailable;
  final bool chargerAvailable;
  final bool waterAvailable;
  final bool wifiAvailable;
  final String vehicleType;      // standard / premium
  final bool isPrimaryVehicle;
  final DateTime createdAt;

  VehicleModel({
    required this.vehicleId,
    required this.driverId,
    required this.registrationNumber,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.seatingCapacity,
    required this.photoUrls,
    required this.registrationCertUrl,
    required this.registrationExpiryDate,
    required this.insuranceProvider,
    required this.insurancePolicyNumber,
    required this.insuranceExpiryDate,
    required this.insuranceDocumentUrl,
    this.acAvailable = false,
    this.chargerAvailable = false,
    this.waterAvailable = false,
    this.wifiAvailable = false,
    this.vehicleType = 'standard',
    this.isPrimaryVehicle = true,
    required this.createdAt,
  });

  VehicleModel copyWith({
    String? vehicleId,
    String? driverId,
    String? registrationNumber,
    String? make,
    String? model,
    int? year,
    String? color,
    int? seatingCapacity,
    List<String>? photoUrls,
    String? registrationCertUrl,
    DateTime? registrationExpiryDate,
    String? insuranceProvider,
    String? insurancePolicyNumber,
    DateTime? insuranceExpiryDate,
    String? insuranceDocumentUrl,
    bool? acAvailable,
    bool? chargerAvailable,
    bool? waterAvailable,
    bool? wifiAvailable,
    String? vehicleType,
    bool? isPrimaryVehicle,
    DateTime? createdAt
  }) {
  return VehicleModel(
      vehicleId: vehicleId ?? this.vehicleId,
      driverId: driverId ?? this.driverId,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      seatingCapacity: seatingCapacity ?? this.seatingCapacity, 
      photoUrls: photoUrls ?? this.photoUrls, 
      registrationCertUrl: registrationCertUrl ?? this.registrationCertUrl, 
      registrationExpiryDate: registrationExpiryDate ?? this.registrationExpiryDate, 
      insuranceProvider: insuranceProvider ?? this.insuranceProvider, 
      insurancePolicyNumber: insurancePolicyNumber ?? this.insurancePolicyNumber, 
      insuranceExpiryDate: insuranceExpiryDate ?? this.insuranceExpiryDate, 
      insuranceDocumentUrl: insuranceDocumentUrl ?? this.insuranceDocumentUrl, 
      acAvailable: acAvailable ?? this.acAvailable, 
      chargerAvailable: chargerAvailable ?? this.chargerAvailable, 
      waterAvailable: waterAvailable ?? this.waterAvailable, 
      wifiAvailable: wifiAvailable ?? this.wifiAvailable, 
      vehicleType: vehicleType ?? this.vehicleType, 
      isPrimaryVehicle: isPrimaryVehicle ?? this.isPrimaryVehicle, 
      createdAt: createdAt ?? this.createdAt
  );
}
}