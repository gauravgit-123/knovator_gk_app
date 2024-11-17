import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../model/posts.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsKey = 'cachedPosts';

  /// Fetch posts with internet check and cache management
  static Future<List<Posts>> fetchPosts() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // Internet is available, fetch from API
      final response = await http.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        final List<dynamic> postList = json.decode(response.body);

        // Save to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(postsKey, json.encode(postList));

        // Map JSON data to Posts model
        return postList.map((post) => Posts.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts from API');
      }
    } else {
      // No internet, load from SharedPreferences
      return await _loadCachedPosts();
    }
  }

  /// Fetch post details from API
  static Future<Posts> fetchPostDetail(int postId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    // Load posts from cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(postsKey);

    if (cachedData != null) {
      final List<dynamic> postList = json.decode(cachedData);

      // Search for the specific post by postId
      final postJson = postList.firstWhere(
            (post) => post['id'] == postId,
        orElse: () => null,
      );

      if (postJson != null) {
        return Posts.fromJson(postJson);
      }
    }

    // If post is not found in cache and internet is available, fetch from API
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));

      if (response.statusCode == 200) {
        final postDetail = json.decode(response.body);

        // Optionally update the cached posts with this detail
        final List<dynamic> updatedPostList = cachedData != null
            ? json.decode(cachedData)
            : [];
        updatedPostList.add(postDetail);

        await prefs.setString(postsKey, json.encode(updatedPostList));

        return Posts.fromJson(postDetail);
      } else {
        throw Exception('Failed to load post details from API');
      }
    }

    // No internet and no cached data available for the requested post
    throw Exception('No internet connection and no cached data for post ID $postId');
  }

  /// Helper function to load cached posts
  static Future<List<Posts>> _loadCachedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(postsKey);

    if (cachedData != null) {
      final List<dynamic> postList = json.decode(cachedData);
      return postList.map((post) => Posts.fromJson(post)).toList();
    } else {
      throw Exception('No cached data available');
    }
  }
}
