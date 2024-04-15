class UserProfileResponse {
  final String? email;
  final String? fullName;
  final bool? isSeekingJob;
  final String? jobTitle;
  final String? imageUrl;
  final String? about;
  final List<WorkExperience>? workExperiences;
  final List<Education>? educationHistories;

  UserProfileResponse({
    this.email,
    this.fullName,
    this.isSeekingJob,
    this.jobTitle,
    this.imageUrl,
    this.about,
    this.workExperiences,
    this.educationHistories
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        email: json['status'] as String?,
        fullName: json['message'] as String?,
        isSeekingJob: json['message'] as bool?,
        jobTitle: json['message'] as String?,
        imageUrl: json['message'] as String?,
        about: json['message'] as String?,
        // workExperiences: json['data'] != null
        //     ? (json['data'] as List)
        //     .map((e) => WorkExperience(
        //   id: e['id'],
        //   company: e['company'],
        //   logo: e['logo'],
        //   jobTitle: e['jobTitle'],
        //   salaryRange: e['salaryRange'],
        //   level: e['level'],
        //   postedAt: DateTime.parse(e['postedAt']),
        //   employmentType: e['employmentType'],
        //   location: e['location'],
        //   skills: List<String>.from(e['skills']),
        //   closingDate: e['closingDate'],
        // ))
        //     .toList()
        //     : null,
        //
        // educationHistories: json['data'] != null
        //     ? (json['data'] as List)
        //     .map((e) => Education(
        //   id: e['id'],
        //   company: e['company'],
        //   logo: e['logo'],
        //   jobTitle: e['jobTitle'],
        //   salaryRange: e['salaryRange'],
        //   level: e['level'],
        //   postedAt: DateTime.parse(e['postedAt']),
        //   employmentType: e['employmentType'],
        //   location: e['location'],
        //   skills: List<String>.from(e['skills']),
        //   closingDate: e['closingDate'],
        // ))
        //     .toList()
        //     : null,
      );
}

class WorkExperience {
  final int? id;
  final String? company;
  final String? yearStart;
  final String? yearEnd;
  final String? jobTitle;
  final String? logoUrl;
  final DateTime? experience;

  WorkExperience({
    this.id,
    this.company,
    this.yearStart,
    this.yearEnd,
    this.jobTitle,
    this.logoUrl,
    this.experience
  });
}

class Education {
  final int? id;
  final String? school;
  final String? yearStart;
  final String? yearEnd;
  final String? logoUrl;
  final String? description;

  Education({
    this.id,
    this.school,
    this.yearStart,
    this.yearEnd,
    this.logoUrl,
    this.description
  });
}