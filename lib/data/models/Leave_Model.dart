import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arch_approve/data/models/User_Model.dart';

enum LeaveStatus { pending, accepted, rejected }

class LeaveModel {
  static const String _idKey = 'id';
  static const String _leaveTypeKey = 'leaveType';
  static const String _startDateKey = 'startDate';
  static const String _endDateKey = 'endDate';
  static const String _reasonKey = 'reason';
  static const String _descriptionKey = 'description';
  static const String _statusKey = 'status';
  static const String _userKey = 'user';
  static const String _attachmentKey = 'attachment';
  static const String _submittedAtKey = 'submittedAt';
  static const String _updatedAtKey = 'updatedAt';
  static const String _approvedByKey = 'approvedBy';
  static const String _approvedAtKey = 'approvedAt';
  static const String _rejectionReasonKey = 'rejectionReason';
  static const String _leaveDurationKey = 'leaveDuration';
  static const String _shouldDeductKey = 'shouldDeduct';
  static const String _deductFormKey = 'deductForm';

  final String? id;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  final String description;
  final LeaveStatus status;
  final UserModel user;
  final Map<String, dynamic>? attachment;
  final DateTime submittedAt;
  final DateTime updatedAt;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? rejectionReason;
  final String leaveDuration;
  final bool shouldDeduct;
  final String deductForm;

  LeaveModel({
    this.id,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.description,
    required this.status,
    required this.user,
    this.attachment,
    required this.submittedAt,
    required this.updatedAt,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    required this.leaveDuration,
    required this.shouldDeduct,
    required this.deductForm,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json[_idKey],
      leaveType: json[_leaveTypeKey] ?? '',
      startDate: json[_startDateKey] ?? '',
      endDate: json[_endDateKey] ?? '',
      reason: json[_reasonKey] ?? '',
      description: json[_descriptionKey] ?? '',
      status: _parseLeaveStatus(json[_statusKey]),
      user: UserModel.fromJson(json[_userKey] ?? {}),
      attachment: json[_attachmentKey],
      submittedAt: _parseDateTime(json[_submittedAtKey]),
      updatedAt: _parseDateTime(json[_updatedAtKey]),
      approvedBy: json[_approvedByKey],
      approvedAt: _parseDateTime(json[_approvedAtKey]),
      rejectionReason: json[_rejectionReasonKey],
      leaveDuration: json[_leaveDurationKey] ?? '',
      shouldDeduct: json[_shouldDeductKey] ?? true,
      deductForm: json[_deductFormKey] ?? '',
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) _idKey: id,
      _leaveTypeKey: leaveType,
      _startDateKey: startDate,
      _endDateKey: endDate,
      _reasonKey: reason,
      _descriptionKey: description,
      _statusKey: status.name,
      _userKey: user.toJson(),
      if (attachment != null) _attachmentKey: attachment,
      _submittedAtKey: submittedAt.toIso8601String(),
      _updatedAtKey: updatedAt.toIso8601String(),
      if (approvedBy != null) _approvedByKey: approvedBy,
      if (approvedAt != null) _approvedAtKey: approvedAt!.toIso8601String(),
      if (rejectionReason != null) _rejectionReasonKey: rejectionReason,
      _leaveDurationKey: leaveDuration,
      _shouldDeductKey: shouldDeduct,
      _deductFormKey: deductForm,
    };
  }

  factory LeaveModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) throw Exception('Document data is null');

    return LeaveModel(
      id: doc.id,
      leaveType: data[_leaveTypeKey] ?? '',
      startDate: data[_startDateKey] ?? '',
      endDate: data[_endDateKey] ?? '',
      reason: data[_reasonKey] ?? '',
      description: data[_descriptionKey] ?? '',
      status: _parseLeaveStatus(data[_statusKey]),
      user: UserModel.fromJson(data[_userKey] ?? {}),
      attachment: data[_attachmentKey],
      submittedAt: _parseDateTime(data[_submittedAtKey]),
      updatedAt: _parseDateTime(data[_updatedAtKey]),
      approvedBy: data[_approvedByKey],
      approvedAt: _parseDateTime(data[_approvedAtKey]),
      rejectionReason: data[_rejectionReasonKey],
      leaveDuration: data[_leaveDurationKey] ?? '',
      shouldDeduct: data[_shouldDeductKey] ?? true,
      deductForm: data[_deductFormKey] ?? '',
    );
  }

  /// To Firestore (same as JSON)
  Map<String, dynamic> toFirestore() => toJson();

  LeaveModel copyWith({
    String? id,
    String? leaveType,
    String? startDate,
    String? endDate,
    String? reason,
    String? description,
    LeaveStatus? status,
    UserModel? user,
    Map<String, dynamic>? attachment,
    DateTime? submittedAt,
    DateTime? updatedAt,
    String? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    String? leaveDuration,
    bool? shouldDeduct,
    String? deductForm,
  }) {
    return LeaveModel(
      id: id ?? this.id,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      status: status ?? this.status,
      user: user ?? this.user,
      attachment: attachment ?? this.attachment,
      submittedAt: submittedAt ?? this.submittedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      leaveDuration: leaveDuration ?? this.leaveDuration,
      shouldDeduct: shouldDeduct ?? this.shouldDeduct,
      deductForm: deductForm ?? this.deductForm,
    );
  }

  /// Helper method to parse LeaveStatus from string
  static LeaveStatus _parseLeaveStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return LeaveStatus.accepted;
      case 'rejected':
        return LeaveStatus.rejected;
      case 'pending':
      default:
        return LeaveStatus.pending;
    }
  }

  /// Helper method to parse DateTime from string
  static DateTime _parseDateTime(dynamic dateTime) {
    if (dateTime is DateTime) return dateTime;
    if (dateTime is String) {
      try {
        return DateTime.parse(dateTime);
      } catch (e) {
        return DateTime.now();
      }
    }
    if (dateTime is Timestamp) return dateTime.toDate();
    return DateTime.now();
  }

  /// Get status display text
  String get statusDisplayText {
    switch (status) {
      case LeaveStatus.pending:
        return 'Pending';
      case LeaveStatus.accepted:
        return 'Accepted';
      case LeaveStatus.rejected:
        return 'Rejected';
    }
  }

  /// Check if leave is pending
  bool get isPending => status == LeaveStatus.pending;

  /// Check if leave is approved
  bool get isApproved => status == LeaveStatus.accepted;

  /// Check if leave is rejected
  bool get isRejected => status == LeaveStatus.rejected;

  /// Check if attachment is from Appwrite
  bool get isAppwriteAttachment {
    return attachment != null && attachment!['appwriteBucketId'] != null;
  }

  /// Get Appwrite file ID if available
  String? get appwriteFileId {
    return attachment?['fileId'];
  }

  /// Get Appwrite bucket ID if available
  String? get appwriteBucketId {
    return attachment?['appwriteBucketId'];
  }

  /// Get file download URL for Appwrite files
  String? get appwriteDownloadUrl {
    if (isAppwriteAttachment &&
        appwriteFileId != null &&
        appwriteBucketId != null) {
      return 'https://cloud.appwrite.io/v1/storage/buckets/$appwriteBucketId/files/$appwriteFileId/view?project=68b52b2600279af18582';
    }
    return null;
  }
}
