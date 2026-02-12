/// All API endpoints in one place.
/// Usage: ApiEndpoints.login
class ApiEndpoints {
  ApiEndpoints._();

  // Base URL - change this per project
  static const String baseUrl = 'https://your-api.com/api/v1';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/auth/profile';

  // Add more endpoints here as needed
}
