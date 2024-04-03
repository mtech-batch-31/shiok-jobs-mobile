class JobApplyResponse {
  final String? status;
  final String? message;

  JobApplyResponse({
    this.status,
    this.message,
  });

  factory JobApplyResponse.fromJson(Map<String, dynamic> json) =>
      JobApplyResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
      );
}
