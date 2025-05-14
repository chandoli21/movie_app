import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view_model.dart';
import '../detail/detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final topPopularMovie =
        vm.popular?.results.isNotEmpty == true ? vm.popular!.results[0] : null;
    return Scaffold(
      body: SafeArea(
        child:
            vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // 상단: 가장 인기있는 텍스트 + popular 첫 번째 영화 커버
                    const Text(
                      '가장 인기있는',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        if (topPopularMovie != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      DetailPage(movieId: topPopularMovie.id),
                            ),
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child:
                              topPopularMovie != null &&
                                      topPopularMovie.posterPath != null
                                  ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${topPopularMovie.posterPath}',
                                    fit: BoxFit.cover,
                                  )
                                  : Container(
                                    color: Colors.grey[800],
                                    child: const Center(
                                      child: Text('가장 인기있는 영화'),
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    MovieHorizontalList(label: '현재 상영중'),
                    MovieHorizontalList(label: '인기순'),
                    MovieHorizontalList(label: '평점 높은순'),
                    MovieHorizontalList(label: '개봉예정'),
                  ],
                ),
      ),
    );
  }
}

class MovieHorizontalList extends StatelessWidget {
  final String label;
  const MovieHorizontalList({required this.label, super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    // 데이터 선택
    final movies =
        label == '인기순'
            ? (vm.popular?.results ?? [])
            : label == '평점 높은순'
            ? (vm.topRated?.results ?? [])
            : label == '개봉예정'
            ? (vm.upcoming?.results ?? [])
            : (vm.nowPlaying?.results ?? []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length > 20 ? 20 : movies.length,
            padding:
                label == '인기순'
                    ? const EdgeInsets.only(left: 32, right: 20)
                    : const EdgeInsets.symmetric(horizontal: 0),
            separatorBuilder:
                (_, __) => SizedBox(width: label == '인기순' ? 32 : 12),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(movieId: movie.id),
                    ),
                  );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (label == '인기순')
                      Positioned(
                        left: -24,
                        bottom: -24,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.95),
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.7),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
