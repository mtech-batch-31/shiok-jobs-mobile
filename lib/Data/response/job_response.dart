class Job {
  final int id;
  final String company;
  // final bool new;
  final String jobTitle;
  final String level;
  final String postedAt;
  final String employeeType;
  final String location;
  final List<String> skills;

  const Job({
    required this.id,
    required this.company,
    // required this.new,
    required this.jobTitle,
    required this.level,
    required this.postedAt,
    required this.employeeType,
    required this.location,
    required this.skills,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      company: json['company'],
      // new: json['new'],
      jobTitle: json['jobTitle'],
      level: json['level'],
      postedAt: json['postedAt'],
      employeeType: json['employeeType'],
      location: json['location'],
      skills: List<String>.from(json['skills']),
    );
  }
}
