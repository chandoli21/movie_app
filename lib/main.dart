import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'presentation/home/home_view_model.dart';
import 'presentation/home/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeViewModel()..fetchAll(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // 다크모드만 지원
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class Movie {
  final String title;
  final String poster;
  final String releaseDate;
  final String tagline;
  final String runtime;
  final List<String> categories;
  final String description;
  final double rating;
  final int voteCount;
  final double popularity;
  final int budget;
  final int revenue;
  final List<String> productionLogos;

  Movie({
    required this.title,
    required this.poster,
    required this.releaseDate,
    required this.tagline,
    required this.runtime,
    required this.categories,
    required this.description,
    required this.rating,
    required this.voteCount,
    required this.popularity,
    required this.budget,
    required this.revenue,
    required this.productionLogos,
  });
}

Future<void> fetchNowPlayingMovies() async {
  final url = Uri.parse(
    'https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1',
  );
  final response = await http.get(
    url,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTM1NDhmMzQ2ZDNmNWRmZDA4YjYyMzhmZWYwYjI3ZCIsIm5iZiI6MS43NDcyNDkxMDU3NzEwMDAxZSs5LCJzdWIiOiI2ODI0ZTdkMTU4MTdlMDJmMmQ2ZWYyMTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.axHv5SW9J2xmxH5G4ygvCqaCzXIIi6Q9Zidca08Xmok',
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data); // 또는 원하는 데이터 파싱
  } else {
    print('Failed to load movies: ${response.statusCode}');
  }
}
