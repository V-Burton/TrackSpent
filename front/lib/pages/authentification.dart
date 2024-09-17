import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../main.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoginMode ? _login : _register,
              child: Text(_isLoginMode ? 'Login' : 'Register'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoginMode = !_isLoginMode;
                });
              },
              child: Text(_isLoginMode
                  ? 'Create an account'
                  : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool success = await authenticateUser(username, password);
    if (success) {
      // Authentification réussie, rediriger vers l'application principale
      var box = Hive.box('user_tokens');
      await box.put('current_user', username);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MainAppScreen()));

    } else {
      // Afficher une erreur
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')));
    }
  }

  Future<void> _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    await saveUserCredentials(username, password);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully')));
    setState(() {
      _isLoginMode = true;
    });
  }
}

/// Biométrie configuration

Future<bool> authenticateWithBiometrics() async {
  final LocalAuthentication auth = LocalAuthentication();
  bool authenticated = false;

  try {
    authenticated = await auth.authenticate(
      localizedReason: 'Please authenticate to log in',
      options: AuthenticationOptions(biometricOnly: true),
    );
  } catch (e) {
    print(e);
  }

  return authenticated;
}

/// User Authentication

String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

Future<void> saveUserCredentials(String userId, String password) async {
  var box = await Hive.openBox('user_credentials');
  String hashedPassword = hashPassword(password);
  await box.put(userId, hashedPassword);
}

Future<bool> authenticateUser(String userId, String password) async {
  var box = await Hive.openBox('user_credentials');
  String? storedHashedPassword = box.get(userId);
  if (storedHashedPassword == null) {
    return false; // L'utilisateur n'existe pas
  }
  String hashedPassword = hashPassword(password);
  return hashedPassword == storedHashedPassword;
}