import 'package:get/get.dart';
import 'package:movies/src/page/detail_movie.dart';
import 'package:movies/src/page/now_playing.dart';
import 'package:movies/src/page/popular.dart';
import 'package:movies/src/page/top_rate.dart';
import 'package:movies/src/page/upcoming.dart';

import '../page/home.dart';
import 'constant.dart';

final List<GetPage<dynamic>>? routes = [
  GetPage(
    name: rootRoute,
    page: () => Home(),
  ),
  GetPage(
    name: detailRoute,
    page: () => DetailMovie(),
  ),
  GetPage(
    name: nowPlayingRoute,
    page: () => NowPlaying(),
  ),
  GetPage(
    name: popularRoute,
    page: () => Popular(),
  ),
  GetPage(
    name: topRateRoute,
    page: () => TopRate(),
  ),
  GetPage(
    name: upcomingRoute,
    page: () => Upcoming(),
  ),
];