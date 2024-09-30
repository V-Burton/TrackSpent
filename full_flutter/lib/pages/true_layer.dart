import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//Gère la connexion du client à TrueLayer
String generateAuthUrl(String clientId, String redirectUri) {
  final Uri uri = Uri.https(
    'auth.truelayer-sandbox.com',
    '/',
    {
      'response_type': 'code',
      'client_id': clientId,
      'scope': 'info accounts balance transactions',
      'redirect_uri': redirectUri,
      'providers': 'uk-ob-all uk-oauth-all',
    },
  );

  return uri.toString();
}

// Requete un token d'accès à TrueLayer grâce au code d'authentification
Future<Map<String, dynamic>> getAccessToken(String code, String clientId, String clientSecret, String redirectUri) async {
  final response = await http.post(
    Uri.https('auth.truelayer-sandbox.com', '/connect/token'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'grant_type': 'authorization_code',
      'client_id': clientId,
      'client_secret': clientSecret,
      'code': code,
      'redirect_uri': redirectUri,
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to obtain access token');
  }
}

//Sauvegarde localement le token obtenu
Future<void> saveTokens(String accessToken, String refreshToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
  await prefs.setString('refresh_token', refreshToken);
}

//Recupère les tokens sauvegardés localement
Future<Map<String, String>> getTokens() async {
  final prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('access_token');
  String? refreshToken = prefs.getString('refresh_token');
  return {
    'access_token': accessToken ?? '',
    'refresh_token': refreshToken ?? '',
  };
}

//Renouvelle le token d'accès
Future<void> refreshAccessToken(String refreshToken, String clientId, String clientSecret) async {
  final response = await http.post(
    Uri.https('auth.truelayer-sandbox.com', '/connect/token'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'client_secret': clientSecret,
      'refresh_token': refreshToken,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    await saveTokens(data['access_token'], data['refresh_token']);
  } else {
    throw Exception('Failed to refresh access token');
  }
}
