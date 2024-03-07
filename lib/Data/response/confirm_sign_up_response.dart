class ConfirmSignUpResponse {
  final ResponseMetadata? responseMetadata;
  final int? contentLength;
  final int? httpStatusCode;

  ConfirmSignUpResponse({
    this.responseMetadata,
    this.contentLength,
    this.httpStatusCode,
  });

  // Factory constructor for easier JSON parsing
  factory ConfirmSignUpResponse.fromJson(Map<String, dynamic> json) =>
      ConfirmSignUpResponse(
        responseMetadata: json['responseMetadata'] != null
            ? ResponseMetadata.fromJson(json['responseMetadata'])
            : null,
        contentLength: json['contentLength'] as int?,
        httpStatusCode: json['httpStatusCode'] as int?,
      );
}

class ResponseMetadata {
  final String? requestId;
  final Metadata? metadata;
  final int? checksumAlgorithm;
  final int? checksumValidationStatus;

  ResponseMetadata({
    this.requestId,
    this.metadata,
    this.checksumAlgorithm,
    this.checksumValidationStatus,
  });

  factory ResponseMetadata.fromJson(Map<String, dynamic> json) =>
      ResponseMetadata(
        requestId: json['requestId'] as String?,
        metadata: json['metadata'] != null ? Metadata() : null,
        checksumAlgorithm: json['checksumAlgorithm'] as int?,
        checksumValidationStatus: json['checksumValidationStatus'] as int?,
      );
}

class Metadata {
  Metadata();
}
