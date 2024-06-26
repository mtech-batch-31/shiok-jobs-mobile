class UserProfileResponse {
  final String? email;
  final String? fullName;
  final bool? isSeekingJob;
  final String? jobTitle;
  final String? imageUrl;
  final String? about;
  final List<WorkExperience>? workExperiences;
  final List<Education>? educationHistories;

  UserProfileResponse(
      {this.email,
      this.fullName,
      this.isSeekingJob,
      this.jobTitle,
      this.imageUrl,
      this.about,
      this.workExperiences,
      this.educationHistories});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        email: json['email'] as String?,
        fullName: json['name'] as String?,
        isSeekingJob: json['seeking'] as bool?,
        jobTitle: json['jobTitle'] as String?,
        imageUrl: json['image'] as String?,
        about: json['about'] as String?,
        workExperiences: json['workExperience'] != null
            ? (json['workExperience'] as List)
                .map((e) => WorkExperience(
                      id: e['id'],
                      company: e['company'],
                      logoUrl: e['logo'],
                      jobTitle: e['jobTitle'],
                      yearStart: e['yearStart'],
                      yearEnd: e['yearEnd'],
                      experience: e['experience'],
                    ))
                .toList()
            : null,
        educationHistories: json['education'] != null
            ? (json['education'] as List)
                .map((e) => Education(
                      id: e['id'],
                      school: e['school'],
                      yearStart: e['yearStart'],
                      yearEnd: e['yearEnd'],
                      logoUrl: e['logo'],
                      description: e['description'],
                    ))
                .toList()
            : null,
      );

      Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = {};
        data['email'] = email;
        data['name'] = fullName;
        data['seeking'] = isSeekingJob;
        data['jobTitle'] = jobTitle;
        data['image'] = imageUrl;
        data['about'] = about;
        if (workExperiences != null) {
          data['workExperience'] = workExperiences!.map((e) => e.toJson()).toList();
        }
        if (educationHistories != null) {
          data['education'] = educationHistories!.map((e) => e.toJson()).toList();
        }
        return data;
      }
}

class WorkExperience {
  final int? id;
  final String? company;
  final String? yearStart;
  final String? yearEnd;
  final String? jobTitle;
  final String? logoUrl;
  final String? experience;

  WorkExperience(
      {this.id,
      this.company,
      this.yearStart,
      this.yearEnd,
      this.jobTitle,
      this.logoUrl,
      this.experience});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['company'] = company;
    data['yearStart'] = yearStart;
    data['yearEnd'] = yearEnd;
    data['jobTitle'] = jobTitle;
    data['logo'] = logoUrl;
    data['experience'] = experience;
    return data;
  }

}

class Education {
  final int? id;
  final String? school;
  final String? yearStart;
  final String? yearEnd;
  final String? logoUrl;
  final String? description;

  Education(
      {this.id,
      this.school,
      this.yearStart,
      this.yearEnd,
      this.logoUrl,
      this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['school'] = school;
    data['yearStart'] = yearStart;
    data['yearEnd'] = yearEnd;
    data['logo'] = logoUrl;
    data['description'] = description;
    return data;
  }

}
