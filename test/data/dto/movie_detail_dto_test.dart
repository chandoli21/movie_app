import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/dto/movie_detail_dto/movie_detail_dto.dart';

void main() {
  test('MovieDetailDto fromJson works', () {
    final json = {
      "id": 1,
      "title": "Test Movie",
      "poster_path": "/test.jpg",
      "overview": "desc",
      "release_date": "2024-01-01",
      "vote_average": 8.5,
      "vote_count": 100,
      "tagline": "A tagline",
      "runtime": 120,
      "genres": [
        {"id": 1, "name": "Action"},
      ],
      "budget": 1000000,
      "revenue": 5000000,
      "production_companies": [
        {
          "id": 1,
          "logo_path": "/logo.png",
          "name": "Test Studio",
          "origin_country": "US",
        },
      ],
      "adult": false,
      "backdrop_path": "/backdrop.jpg",
      "belongs_to_collection": null,
      "homepage": "",
      "imdb_id": "tt1234567",
      "original_language": "en",
      "original_title": "Test Movie",
      "popularity": 100.0,
      "status": "Released",
      "video": false,
    };
    final dto = MovieDetailDto.fromJson(json);
    expect(dto.id, 1);
    expect(dto.title, "Test Movie");
    expect(dto.genres.first.name, "Action");
    expect(dto.productionCompanies.first.name, "Test Studio");
  });
}
