class JobsListingResponse {
  final int? index;
  final int? pageSize;
  final int? totalRecord;
  final dynamic sortBy;
  final List<JobSummary>? data;

  JobsListingResponse({
    this.index,
    this.pageSize,
    this.totalRecord,
    this.sortBy,
    this.data,
  });

  factory JobsListingResponse.fromJson(Map<String, dynamic> json) {
    return JobsListingResponse(
      index: json['index'],
      pageSize: json['pageSize'],
      totalRecord: json['totalRecord'],
      sortBy: json['sortBy'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => JobSummary(
                    id: e['id'],
                    company: e['company'],
                    logo: e['logo'],
                    jobTitle: e['jobTitle'],
                    salaryRange: e['salaryRange'],
                    level: e['level'],
                    postedAt: DateTime.parse(e['postedAt']),
                    employmentType: e['employmentType'],
                    location: e['location'],
                    skills: List<String>.from(e['skills']),
                    closingDate: e['closingDate'],
                  ))
              .toList()
          : null,
    );
  }
}

class JobSummary {
  final int? id;
  final String? company;
  final String? logo;
  final String? jobTitle;
  final String? salaryRange;
  final String? level;
  final DateTime? postedAt;
  final String? employmentType;
  final String? location;
  final List<String>? skills;
  final int? closingDate;

  JobSummary({
    this.id,
    this.company,
    this.logo,
    this.jobTitle,
    this.salaryRange,
    this.level,
    this.postedAt,
    this.employmentType,
    this.location,
    this.skills,
    this.closingDate,
  });
}
