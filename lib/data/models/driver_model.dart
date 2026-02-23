// lib/data/models/driver_model.dart
class DriverModel {
  final String userId;          // linked to UserModel.uid
  String? licenseNumber;
  DateTime? licenseExpiryDate;
  String? licenseDocumentUrl;  // uploaded license image
  String? governmentIdNumber;
  String? governmentIdUrl;     // uploaded ID card
  String? profilePhotoUrl;     // driver profile picture
  String? bankAccountNumber;
  String? bankName;
  String? ifscCode;
  String? taxId;
  String? verificationStatus;  // pending / verified / rejected
  DateTime? verificationDate;
  bool isActive;              // online/offline toggle
  double totalEarnings;
  int totalRides;
  double averageRating;
  int cancellationCount;
  double acceptanceRate;
  DateTime? createdAt;

  DriverModel({
    required this.userId,
    this.licenseNumber,
    this.licenseExpiryDate,
    this.licenseDocumentUrl,
    this.governmentIdNumber,
    this.governmentIdUrl,
    this.profilePhotoUrl,
    this.bankAccountNumber,
    this.bankName,
    this.ifscCode,
    this.taxId,
    this.verificationStatus = 'pending',
    this.verificationDate,
    this.isActive = false,
    this.totalEarnings = 0.0,
    this.totalRides = 0,
    this.averageRating = 0.0,
    this.cancellationCount = 0,
    this.acceptanceRate = 0.0,
    this.createdAt,
  });

  DriverModel copyWith({
    String? userId,
    String? licenseNumber,
    DateTime? licenseExpiryDate,
    String? licenseDocumentUrl,
    String? governmentIdNumber,
    String? governmentIdUrl,
    String? profilePhotoUrl,
    String? bankAccountNumber,
    String? bankName,
    String? ifscCode,
    String? taxId,
    String? verificationStatus,
    DateTime? verificationDate,
    bool? isActive,
    double? totalEarnings,
    int? totalRides,
    double? averageRating,
    int? cancellationCount,
    double? acceptanceRate,
    DateTime? createdAt,
  }) {
    return DriverModel(
      userId: userId ?? this.userId,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseExpiryDate: licenseExpiryDate ?? this.licenseExpiryDate,
      licenseDocumentUrl: licenseDocumentUrl ?? this.licenseDocumentUrl,
      governmentIdNumber: governmentIdNumber ?? this.governmentIdNumber,
      governmentIdUrl: governmentIdUrl ?? this.governmentIdUrl,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankName: bankName ?? this.bankName,
      ifscCode: ifscCode ?? this.ifscCode,
      taxId: taxId ?? this.taxId,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      verificationDate: verificationDate ?? this.verificationDate,
      isActive: isActive ?? this.isActive,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      totalRides: totalRides ?? this.totalRides,
      averageRating: averageRating ?? this.averageRating,
      cancellationCount: cancellationCount ?? this.cancellationCount,
      acceptanceRate: acceptanceRate ?? this.acceptanceRate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}