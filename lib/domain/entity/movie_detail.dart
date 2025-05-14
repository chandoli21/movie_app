class MovieDetail {
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final String? tagline;
  final int? runtime;
  final List<String>? genres;
  final int? budget;
  final int? revenue;
  final List<String>? productionCompanyLogos;

  MovieDetail({
    required this.id,
    required this.title,
    this.posterPath,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.tagline,
    this.runtime,
    this.genres,
    this.budget,
    this.revenue,
    this.productionCompanyLogos,
  });
}
