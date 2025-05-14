import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/dto/movie_response_dto/movie_response_dto.dart';

void main() {
  test('MovieResponseDto fromJson works', () {
    final json = {
      "page": 1,
      "results": [
        {
          "id": 1,
          "title": "Test Movie",
          "poster_path": "/test.jpg",
          "overview": "desc",
          "release_date": "2024-01-01",
          "vote_average": 8.5,
          "genre_ids": [],
          "adult": false,
          "original_language": "en",
          "original_title": "Test Movie",
          "popularity": 100.0,
          "video": false,
          "vote_count": 100,
        },
      ],
      "total_pages": 1,
      "total_results": 1,
    };
    final dto = MovieResponseDto.fromJson(json);
    expect(dto.page, 1);
    expect(dto.results.first.title, "Test Movie");
  });
}
