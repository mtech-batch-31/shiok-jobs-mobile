import 'package:shiok_jobs_flutter/Data/response/user_profile_response.dart';

class UserProfileRequest {
  String? email;
  String? fullName;
  bool? isSeekingJob;
  String? jobTitle;
  String? imageUrl;
  String? about;
  List<WorkExperience>? workExperiences;
  List<Education>? educationHistories;

  UserProfileRequest(
      {this.email,
      this.fullName,
      this.isSeekingJob,
      this.jobTitle,
      this.imageUrl,
      this.about,
      this.workExperiences,
      this.educationHistories});

  factory UserProfileRequest.fromJson(Map<String, dynamic> json) =>
      UserProfileRequest(
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

      // Setter method for email
      void setEmail(String newEmail) {
        email = newEmail;
      }
}

