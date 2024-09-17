import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> authenticate() async {
  final result = await FlutterWebAuth.authenticate(
    url: 'https://api.treulayer.com/auth/authorize?client_id=YOUR_CLIENT_ID&response_type=token&redirect_uri=YOUR_REDIRECT_URI',
    callbackUrlScheme: 'YOUR_REDIRECT_URI_SCHEME',
  );

  // Extract the token from the result
  final token = Uri.parse(result).fragment.split('&').firstWhere((e) => e.startsWith('access_token=')).split('=')[1];

  // Save the token for future requests
  await saveToken(token);
}


Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

Future<YourResponseType> fetchFromRustBackend() async {
  final token = await getToken();
  final response = await http.get(
    Uri.parse('http://your_backend_url/your_endpoint'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return YourResponseType.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}


Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
}

