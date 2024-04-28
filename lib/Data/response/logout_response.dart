class LogoutResponse {
  final ResponseMetadata? responseMetadata;
  final int? contentLength;
  final int? httpStatusCode;

  LogoutResponse({
    this.responseMetadata,
    this.contentLength,
    this.httpStatusCode,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      responseMetadata: json['responseMetadata'] != null
          ? ResponseMetadata(
              requestId: json['responseMetadata']['requestId'],
              metadata: json['responseMetadata']['metadata'] != null
                  ? Metadata()
                  : null,
              checksumAlgorithm: json['responseMetadata']['checksumAlgorithm'],
              checksumValidationStatus: json['responseMetadata']
                  ['checksumValidationStatus'],
            )
          : null,
      contentLength: json['contentLength'],
      httpStatusCode: json['httpStatusCode'],
    );
  }
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
}

class Metadata {
  Metadata();
}
