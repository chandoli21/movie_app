import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detail_view_model.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final int movieId;
  const DetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel()..fetchDetail(movieId),
      child: Consumer<DetailViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final detail = vm.detail;
          final formatter = NumberFormat('#,###');
          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // 포스터: 가로 전체
                  (detail != null && detail.posterPath != null)
                      ? AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${detail.posterPath}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      : Container(
                        height: 300,
                        color: Colors.grey[800],
                        width: double.infinity,
                        child: const Center(child: Text('No Image')),
                      ),
                  // 나머지 정보는 패딩 적용
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail?.title ?? '',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          detail?.releaseDate ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          detail?.tagline ?? '',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 8),
                        Text('러닝타임: ${detail?.runtime ?? '-'}분'),
                        Wrap(
                          spacing: 8,
                          children:
                              detail?.genres
                                  .map((g) => Chip(label: Text(g.name)))
                                  .toList() ??
                              [],
                        ),
                        const SizedBox(height: 12),
                        Text(detail?.overview ?? ''),
                        const SizedBox(height: 20),
                        // 평점, 투표수, 인기점수, 예산, 수익 가로 리스트뷰
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _InfoCard(
                                label: '평점',
                                value: detail?.voteAverage.toString() ?? '',
                              ),
                              _InfoCard(
                                label: '투표수',
                                value: detail?.voteCount.toString() ?? '',
                              ),
                              _InfoCard(
                                label: '인기점수',
                                value: detail?.popularity.toString() ?? '',
                              ),
                              _InfoCard(
                                label: '예산',
                                value:
                                    detail?.budget != null
                                        ? '\$${formatter.format(detail!.budget)}'
                                        : '',
                              ),
                              _InfoCard(
                                label: '수익',
                                value:
                                    detail?.revenue != null
                                        ? '\$${formatter.format(detail!.revenue)}'
                                        : '',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 제작사 로고 가로 리스트뷰
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: detail?.productionCompanies.length ?? 0,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 12),
                            itemBuilder:
                                (context, idx) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child:
                                      detail
                                                  ?.productionCompanies[idx]
                                                  .logoPath !=
                                              null
                                          ? Image.network(
                                            'https://image.tmdb.org/t/p/w200${detail?.productionCompanies[idx].logoPath}',
                                          )
                                          : Container(),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  const _InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
