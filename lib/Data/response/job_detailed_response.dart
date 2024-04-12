class JobDetail {
  final int? id;
  final int? companyId;
  final String? companyName;
  final String? jobTitle;
  final String? jobSummary;
  final String? jobCategory;
  final String? level;
  final List<String>? skills;
  final String? employmentType;
  final String? location;
  final String? workHours;
  final double? minSalary;
  final double? maxSalary;
  final DateTime? postedDate;
  final DateTime? closingDate;
  final int? version;
  final String? lastUpdatedBy;
  final DateTime? lastUpdatedTime;
  final String? createdBy;
  final DateTime? createdTime;
  final dynamic applied;

  JobDetail({
    this.id,
    this.companyId,
    this.companyName,
    this.jobTitle,
    this.jobSummary,
    this.jobCategory,
    this.level,
    this.skills,
    this.employmentType,
    this.location,
    this.workHours,
    this.minSalary,
    this.maxSalary,
    this.postedDate,
    this.closingDate,
    this.version,
    this.lastUpdatedBy,
    this.lastUpdatedTime,
    this.createdBy,
    this.createdTime,
    this.applied,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      id: json['id'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      jobSummary: json['jobSummary'],
      jobCategory: json['jobCategory'],
      level: json['level'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      employmentType: json['employmentType'],
      location: json['location'],
      workHours: json['workHours'],
      minSalary: json['minSalary'],
      maxSalary: json['maxSalary'],
      postedDate: DateTime.fromMillisecondsSinceEpoch(json['postedDate']),
      closingDate: DateTime.fromMillisecondsSinceEpoch(json['closingDate']),
      version: json['version'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedTime:
          DateTime.fromMillisecondsSinceEpoch(json['lastUpdatedTime']),
      createdBy: json['createdBy'],
      createdTime: DateTime.fromMillisecondsSinceEpoch(json['createdTime']),
      applied: json['applied'],
    );
  }
}
