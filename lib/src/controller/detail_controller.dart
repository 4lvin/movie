import 'package:get/get.dart';
import 'package:movies/src/models/detailMovieModel.dart';
import 'package:movies/src/models/nowPlayingModel.dart';
import 'package:movies/src/services/api.dart';

class DetailController extends GetxController {
  var isLoading = true.obs;
  var detail = DetailMovieModel().obs;

  @override
  void onInit() {
    getDetail(Get.arguments[0]);
    super.onInit();
  }

  void getDetail(String id) async {
    try {
      isLoading(true);
      var res = await ApiService().detailMovie(id);
      if (res != null) {
        detail.value = res;
      } else {}
    } finally {
      isLoading(false);
    }
  }
}
