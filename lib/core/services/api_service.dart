import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Android Emulator: 10.0.2.2:8080
  // static const baseUrl = 'http://10.0.2.2:8080';
  static const baseUrl = 'http://localhost:8080';


  static Future<Map<String, dynamic>> getExample() async {
    final url = Uri.parse('$baseUrl/api');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  static Future<void> postExample(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/api');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}