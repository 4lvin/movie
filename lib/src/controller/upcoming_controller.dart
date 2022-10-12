import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/src/models/upcomingModel.dart';
import 'package:movies/src/services/api.dart';

class UpcomingController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPage = false.obs;
  var upcoming = <Results>[].obs;
  final scrollController = ScrollController();
  int _pageNo = 1;

  @override
  void onInit() {
    getUpcoming();
    scrollController.addListener(() {
      _scrollListener();
    });
    super.onInit();
  }

  void getUpcoming() async {
    try {
      isLoading(true);
      var res = await ApiService().upcoming("1");
      if (res != null) {
        upcoming.assignAll(res);
      } else {}
    } finally {
      isLoading(false);
    }
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadingPage(true);
      _pageNo++;
      try {
        await Future.delayed(Duration(seconds: 3));
        final res = await ApiService().upcoming(_pageNo.toString());
        if (res!.isEmpty) {
          isLoadingPage(false);
        } else {
          isLoadingPage(false);
          if (_pageNo != 1) {
            upcoming.addAll(res);
          }
        }
      } catch (err) {
        isLoadingPage(false);
        Get.rawSnackbar(message: err.toString());
      }
    }
  }
}
