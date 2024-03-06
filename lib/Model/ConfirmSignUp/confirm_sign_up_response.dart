import 'package:flutter/foundation.dart';
import 'package:shiok_jobs_flutter/Model/error_response.dart';

class ConfirmSignUpModel extends ErrorResponse {
  final ResponseMetadata? responseMetadata;
  final int? contentLength;
  final int? httpStatusCode;

  ConfirmSignUpModel({
    this.responseMetadata,
    this.contentLength,
    this.httpStatusCode,
  });

  // Factory constructor for easier JSON parsing
  factory ConfirmSignUpModel.fromJson(Map<String, dynamic> json) =>
      ConfirmSignUpModel(
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
