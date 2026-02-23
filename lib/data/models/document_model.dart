// lib/data/models/document_model.dart
class DocumentModel {
  final String documentId;
  final String driverId;
  final String documentType;   // license / id / insurance / registration
  final String documentNumber;
  final String documentUrl;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String verificationStatus; // pending / verified / expired / rejected
  final DateTime? verificationDate;
  final String? rejectionReason;

  DocumentModel({
    required this.documentId,
    required this.driverId,
    required this.documentType,
    required this.documentNumber,
    required this.documentUrl,
    required this.issueDate,
    required this.expiryDate,
    this.verificationStatus = 'pending',
    this.verificationDate,
    this.rejectionReason,
  });
}