import 'location_model.dart';

enum RideStatus {
  requested,
  accepted,
  driverArrived,
  inProgress,
  completed,
  cancelled,
}

class RideModel {
  final String rideId;
  final String userId;
  final String? driverId;
  final String? vehicleId;
  final LocationModel pickupLocation;
  final LocationModel destinationLocation;
  final DateTime? pickupTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final RideStatus status;
  final double? distanceKm;
  final int? durationMinutes;
  final String rideType; // standard, premium, shared
  final double estimatedFare;
  final double? actualFare;
  final String? paymentMethod;
  final String? paymentStatus;
  final double? tipAmount;
  final String? cancellationReason;
  final String? cancelledBy;
  final String? routePolyline;
  final DateTime createdAt;

  RideModel({
    required this.rideId,
    required this.userId,
    this.driverId,
    this.vehicleId,
    required this.pickupLocation,
    required this.destinationLocation,
    this.pickupTime,
    this.startTime,
    this.endTime,
    required this.status,
    this.distanceKm,
    this.durationMinutes,
    required this.rideType,
    required this.estimatedFare,
    this.actualFare,
    this.paymentMethod,
    this.paymentStatus,
    this.tipAmount,
    this.cancellationReason,
    this.cancelledBy,
    this.routePolyline,
    required this.createdAt,
  });

  RideModel copyWith({
    String? rideId,
    String? userId,
    String? driverId,
    String? vehicleId,
    LocationModel? pickupLocation,
    LocationModel? destinationLocation,
    DateTime? pickupTime,
    DateTime? startTime,
    DateTime? endTime,
    RideStatus? status,
    double? distanceKm,
    int? durationMinutes,
    String? rideType,
    double? estimatedFare,
    double? actualFare,
    String? paymentMethod,
    String? paymentStatus,
    double? tipAmount,
    String? cancellationReason,
    String? cancelledBy,
    String? routePolyline,
    DateTime? createdAt,
  }) {
    return RideModel(
      rideId: rideId ?? this.rideId,
      userId: userId ?? this.userId,
      driverId: driverId ?? this.driverId,
      vehicleId: vehicleId ?? this.vehicleId,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      pickupTime: pickupTime ?? this.pickupTime,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      rideType: rideType ?? this.rideType,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      actualFare: actualFare ?? this.actualFare,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      tipAmount: tipAmount ?? this.tipAmount,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      cancelledBy: cancelledBy ?? this.cancelledBy,
      routePolyline: routePolyline ?? this.routePolyline,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}