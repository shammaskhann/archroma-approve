class LeaveStatsModel {
  static const String _casualLeavesKey = 'casual_leaves';
  static const String _annualLeavesKey = 'annual_leaves';
  static const String _sickLeavesKey = 'sick_leaves';

  final int casualLeaves;
  final int annualLeaves;
  final int sickLeaves;

  LeaveStatsModel({
    required this.casualLeaves,
    required this.annualLeaves,
    required this.sickLeaves,
  });

  /// From JSON
  factory LeaveStatsModel.fromJson(Map<String, dynamic> json) {
    return LeaveStatsModel(
      casualLeaves: json[_casualLeavesKey] ?? 0,
      annualLeaves: json[_annualLeavesKey] ?? 0,
      sickLeaves: json[_sickLeavesKey] ?? 0,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      _casualLeavesKey: casualLeaves,
      _annualLeavesKey: annualLeaves,
      _sickLeavesKey: sickLeaves,
    };
  }

  /// Copy with
  LeaveStatsModel copyWith({
    int? casualLeaves,
    int? annualLeaves,
    int? sickLeaves,
  }) {
    return LeaveStatsModel(
      casualLeaves: casualLeaves ?? this.casualLeaves,
      annualLeaves: annualLeaves ?? this.annualLeaves,
      sickLeaves: sickLeaves ?? this.sickLeaves,
    );
  }

  /// Initialize with default values (20 each)
  factory LeaveStatsModel.initial() {
    return LeaveStatsModel(casualLeaves: 20, annualLeaves: 20, sickLeaves: 20);
  }
}
