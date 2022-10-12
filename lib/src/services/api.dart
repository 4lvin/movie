import 'dart:convert';

import 'package:get/get.dart';
import 'package:movies/src/models/detailMovieModel.dart';
import 'package:movies/src/models/nowPlayingModel.dart';
import 'package:movies/src/models/topRateModel.dart';
import 'package:movies/src/services/app_exception.dart';
import 'package:movies/src/services/base_client.dart';
import 'package:movies/src/services/base_controller.dart';

import '../config/env.dart';
import '../models/popularModel.dart';
import '../models/upcomingModel.dart';

class ApiService extends GetConnect with BaseController {
  Future nowPlaying(String page) async {
    final response = await BaseClient()
        .get(BASE_URL, '/now_playing?api_key=af167b1fede374e9beb4a9237bc4b071&language=en-US&page=$page')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var playing = nowPlayiFromJson(response);
      return playing.results;
    } else {
      return null;
    }
  }

  Future popular(String page) async {
    final response = await BaseClient()
        .get(BASE_URL, '/popular?api_key=af167b1fede374e9beb4a9237bc4b071&language=en-US&page=$page')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var popular = popularFromJson(response);
      return popular.results;
    } else {
      return null;
    }
  }

  Future topRate(String page) async {
    final response = await BaseClient()
        .get(BASE_URL, '/top_rated?api_key=af167b1fede374e9beb4a9237bc4b071&language=en-US&page=$page')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var popular = topRateModelFromJson(response);
      return popular.results;
    } else {
      return null;
    }
  }

  Future upcoming(String page) async {
    final response = await BaseClient()
        .get(BASE_URL, '/upcoming?api_key=af167b1fede374e9beb4a9237bc4b071&language=en-US&page=$page')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var upcoming = upcomingModelFromJson(response);
      return upcoming.results;
    } else {
      return null;
    }
  }

  Future detailMovie(String id) async {
    final response = await BaseClient()
        .get(BASE_URL, '/$id?api_key=af167b1fede374e9beb4a9237bc4b071&language=en-US')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var detail = detailMovieFromJson(response);
      return detail;
    } else {
      return null;
    }
  }
}