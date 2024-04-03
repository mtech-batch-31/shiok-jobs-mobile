class JobApplyRequest {
  final int? id;

  JobApplyRequest({
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
