import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_detail.dart';
import '../dto/movie_response_dto/movie_response_dto.dart';
import '../dto/movie_detail_dto/movie_detail_dto.dart';
import '../datasource/movie_data_source.dart';
import '../../domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource dataSource;
  MovieRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async {
    final dto = await dataSource.fetchNowPlayingMovies();
    return dto?.results.map(_toEntity).toList();
  }

  @override
  Future<List<Movie>?> fetchPopularMovies() async {
    final dto = await dataSource.fetchPopularMovies();
    return dto?.results.map(_toEntity).toList();
  }

  @override
  Future<List<Movie>?> fetchTopRatedMovies() async {
    final dto = await dataSource.fetchTopRatedMovies();
    return dto?.results.map(_toEntity).toList();
  }

  @override
  Future<List<Movie>?> fetchUpcomingMovies() async {
    final dto = await dataSource.fetchUpcomingMovies();
    return dto?.results.map(_toEntity).toList();
  }

  @override
  Future<MovieDetail?> fetchMovieDetail(int id) async {
    final dto = await dataSource.fetchMovieDetail(id);
    return dto == null ? null : _toDetailEntity(dto);
  }

  Movie _toEntity(MovieResultDto dto) => Movie(
    id: dto.id,
    title: dto.title,
    posterPath: dto.posterPath,
    overview: dto.overview,
    releaseDate: dto.releaseDate,
    voteAverage: dto.voteAverage,
  );

  MovieDetail _toDetailEntity(MovieDetailDto dto) => MovieDetail(
    id: dto.id,
    title: dto.title,
    posterPath: dto.posterPath,
    overview: dto.overview,
    releaseDate: dto.releaseDate,
    voteAverage: dto.voteAverage,
    voteCount: dto.voteCount,
    tagline: dto.tagline,
    runtime: dto.runtime,
    genres: dto.genres.map((g) => g.name).toList(),
    budget: dto.budget,
    revenue: dto.revenue,
    productionCompanyLogos:
        dto.productionCompanies
            .map((c) => c.logoPath)
            .whereType<String>()
            .toList(),
  );
}
