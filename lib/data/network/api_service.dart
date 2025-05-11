import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/apiResponse.dart';
import '../response/api_response.dart';

class ApiService {

 static dynamic removeHtmlTagsFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      // If the JSON is a map, process each key-value pair
      return json.map((key, value) {
        return MapEntry(key, removeHtmlTagsFromJson(value));
      });
    } else if (json is List) {
      // If the JSON is a list, process each item
      return json.map((item) => removeHtmlTagsFromJson(item)).toList();
    } else if (json is String) {
      // If the JSON value is a string, strip HTML tags
      return stripHtmlTags(json);
    } else {
      // Return the value as-is (e.g., for numbers, booleans, etc.)
      return json;
    }
  }

  /// Strips HTML tags from a string
 static String stripHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }
  static const String baseUrl = 'https://jsonblob.com/api/jsonBlob/1346011103062319104';

  static Future<ApiResponse> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final cleanedJson = removeHtmlTagsFromJson(jsonData); // Clean the JSON
        return ApiResponse.fromJson(cleanedJson);
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}