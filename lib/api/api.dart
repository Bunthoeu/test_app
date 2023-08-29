import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/model/model.dart';
import 'package:test_app/model/provice.dart';

import '../model/social.dart';

class APIservice {
  static String basUrl = 'https://test-superapp-api.idev.group/mobile';
  final String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90ZXN0LXN1cGVyYXBwLWFwaS5pZGV2Lmdyb3VwXC9tb2JpbGVcL2xvZ2luIiwiaWF0IjoxNjkzMTk3Mzc1LCJleHAiOjEzMTY4ODE3NTg3NSwibmJmIjoxNjkzMTk3Mzc1LCJqdGkiOiJEZno2Yk11cmhDTnhpN0xIIiwic3ViIjo3MiwicHJ2IjoiMjkyZDI2ZmQ5NzExY2RkNjk2ZWUwNmE5N2NjYjliZmNmN2RlZmUyZSJ9.ByTHmx7otLvyfrncnIFvkZhul6hOFOUmu19JI-0w-e8';
  Future<List> getAttraction() async {
    final response = await http.post(
      Uri.parse('${basUrl}/get_social_contact_list'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Social> socials = data.map((item) => Social.fromJson(item)).toList();
      return socials;
    } else {
      throw Exception('Failed to fetch socials');
    }
  }

  Future<List<Posts>> getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Posts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<List<Social>> fetchSocials() async {
    final response = await http.post(
      Uri.parse('${basUrl}/get_social_contact_list'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Social> socials = data.map((item) => Social.fromJson(item)).toList();
      return socials;
    } else {
      throw Exception('Failed to fetch socials');
    }
  }

  Future<List<Provice>> fetchProvice() async {
    final response = await http.post(
      Uri.parse('${basUrl}/get_province_list'),
      headers: {'Authorization': 'Bearer $token'},
    );
     if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var dataList = jsonData['data'] as List<dynamic>;

      return dataList.map((data) => Provice.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

    // if (response.statusCode == 200) {
    //   List<dynamic> data = jsonDecode(response.body)['data'];
    //   List<Provice> provices =
    //       data.map((item) => Provice.fromJson(item)).toList();
    //   return provices;
    // } else {
    //   throw Exception('Failed to fetch socials');
    // }
  }
