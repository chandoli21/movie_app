import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/dto/movie_response_dto/movie_response_dto.dart';

class HomeViewModel extends ChangeNotifier {
  MovieResponseDto? nowPlaying;
  MovieResponseDto? popular;
  MovieResponseDto? topRated;
  MovieResponseDto? upcoming;
  bool isLoading = false;

  Future<void> fetchAll() async {
    isLoading = true;
    notifyListeners();

    // Fetch now playing
    final nowPlayingUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1',
    );
    final nowPlayingResponse = await http.get(
      nowPlayingUrl,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTM1NDhmMzQ2ZDNmNWRmZDA4YjYyMzhmZWYwYjI3ZCIsIm5iZiI6MS43NDcyNDkxMDU3NzEwMDAxZSs5LCJzdWIiOiI2ODI0ZTdkMTU4MTdlMDJmMmQ2ZWYyMTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.axHv5SW9J2xmxH5G4ygvCqaCzXIIi6Q9Zidca08Xmok',
        'accept': 'application/json',
      },
    );
    if (nowPlayingResponse.statusCode == 200) {
      nowPlaying = MovieResponseDto.fromJson(
        jsonDecode(nowPlayingResponse.body),
      );
    }

    // Fetch popular
    final popularUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?language=ko-KR&page=1',
    );
    final popularResponse = await http.get(
      popularUrl,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTM1NDhmMzQ2ZDNmNWRmZDA4YjYyMzhmZWYwYjI3ZCIsIm5iZiI6MS43NDcyNDkxMDU3NzEwMDAxZSs5LCJzdWIiOiI2ODI0ZTdkMTU4MTdlMDJmMmQ2ZWYyMTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.axHv5SW9J2xmxH5G4ygvCqaCzXIIi6Q9Zidca08Xmok',
        'accept': 'application/json',
      },
    );
    if (popularResponse.statusCode == 200) {
      popular = MovieResponseDto.fromJson(jsonDecode(popularResponse.body));
    }

    // Fetch top rated
    final topRatedUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?language=ko-KR&page=1',
    );
    final topRatedResponse = await http.get(
      topRatedUrl,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTM1NDhmMzQ2ZDNmNWRmZDA4YjYyMzhmZWYwYjI3ZCIsIm5iZiI6MS43NDcyNDkxMDU3NzEwMDAxZSs5LCJzdWIiOiI2ODI0ZTdkMTU4MTdlMDJmMmQ2ZWYyMTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.axHv5SW9J2xmxH5G4ygvCqaCzXIIi6Q9Zidca08Xmok',
        'accept': 'application/json',
      },
    );
    if (topRatedResponse.statusCode == 200) {
      topRated = MovieResponseDto.fromJson(jsonDecode(topRatedResponse.body));
    }

    // Fetch upcoming
    final upcomingUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming?language=ko-KR&page=1',
    );
    final upcomingResponse = await http.get(
      upcomingUrl,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTM1NDhmMzQ2ZDNmNWRmZDA4YjYyMzhmZWYwYjI3ZCIsIm5iZiI6MS43NDcyNDkxMDU3NzEwMDAxZSs5LCJzdWIiOiI2ODI0ZTdkMTU4MTdlMDJmMmQ2ZWYyMTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.axHv5SW9J2xmxH5G4ygvCqaCzXIIi6Q9Zidca08Xmok',
        'accept': 'application/json',
      },
    );
    if (upcomingResponse.statusCode == 200) {
      upcoming = MovieResponseDto.fromJson(jsonDecode(upcomingResponse.body));
    }

    isLoading = false;
    notifyListeners();
  }
}
