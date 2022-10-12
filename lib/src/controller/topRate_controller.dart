import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/src/models/topRateModel.dart';
import 'package:movies/src/services/api.dart';

class TopRateController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPage = false.obs;
  var topRate = <Results>[].obs;
  final scrollController = ScrollController();
  int _pageNo = 1;

  @override
  void onInit() {
    getTopRate();
    scrollController.addListener(() {
      _scrollListener();
    });
    super.onInit();
  }

  void getTopRate() async {
    try {
      isLoading(true);
      var res = await ApiService().topRate("1");
      if (res != null) {
        topRate.assignAll(res);
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
        final res = await ApiService().topRate(_pageNo.toString());
        if (res!.isEmpty) {
          isLoadingPage(false);
        } else {
          isLoadingPage(false);
          if (_pageNo != 1) {
            topRate.addAll(res);
          }
        }
      } catch (err) {
        isLoadingPage(false);
        Get.rawSnackbar(message: err.toString());
      }
    }
  }
}
