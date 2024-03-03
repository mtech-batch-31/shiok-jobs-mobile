// Define the top-level class to represent the entire JSON object
class CodeDeliveryResponse {
  final CodeDeliveryDetails? codeDeliveryDetails;
  final bool? userConfirmed;
  final String? userSub;
  final int? httpStatusCode;
  final String? error;

  CodeDeliveryResponse({
    this.userConfirmed,
    this.userSub,
    this.httpStatusCode,
    this.codeDeliveryDetails,
    this.error,
  });

  // Factory constructor for easier JSON parsing
  factory CodeDeliveryResponse.fromJson(Map<String, dynamic> json) =>
      CodeDeliveryResponse(
        userConfirmed: json['userConfirmed'] as bool?,
        userSub: json['userSub'] as String?,
        httpStatusCode: json['httpStatusCode'] as int?,
        codeDeliveryDetails: json['codeDeliveryDetails'] != null
            ? CodeDeliveryDetails.fromJson(json['codeDeliveryDetails'])
            : null, // Handle potential null value for codeDeliveryDetails
        error: json['error'] as String?,
      );

  // Additional methods (optional):
  // - toJson() to convert back to JSON
  // - getters and setters for individual fields
  // - validation logic for fields
}

// Nested classes
class CodeDeliveryDetails {
  final String attributeName;
  final DeliveryMedium deliveryMedium;
  final String destination;

  CodeDeliveryDetails({
    required this.attributeName,
    required this.deliveryMedium,
    required this.destination,
  });

  factory CodeDeliveryDetails.fromJson(Map<String, dynamic> json) =>
      CodeDeliveryDetails(
        attributeName: json['attributeName'] as String,
        deliveryMedium: DeliveryMedium.fromJson(json['deliveryMedium']),
        destination: json['destination'] as String,
      );
}

class DeliveryMedium {
  final String value;

  DeliveryMedium({required this.value});

  factory DeliveryMedium.fromJson(Map<String, dynamic> json) =>
      DeliveryMedium(value: json['value'] as String);
}
