import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class UserProfileRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_JOBS'];

  // Future<List<JobSummary>?> getAllJobs() async {
  //   final jobApiEndPoint = '$apiURL/jobs';
  //   _networkClient.setHeaders({'Content-Type': 'application/json'});
  //   final response = await _networkClient.get(
  //     jobApiEndPoint,
  //   );
  //   return JobsListingResponse.fromJson(response).data;
  // }
}