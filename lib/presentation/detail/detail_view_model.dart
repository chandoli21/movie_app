import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/dto/movie_detail_dto/movie_detail_dto.dart';

class DetailViewModel extends ChangeNotifier {
  MovieDetailDto? detail;
  bool isLoading = false;

  Future<void> fetchDetail(int id) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/id?language=ko-KR'.replaceFirst(
        'id',
        id.toString(),
      ),
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
      detail = MovieDetailDto.fromJson(jsonDecode(response.body));
    }
    isLoading = false;
    notifyListeners();
  }
}
