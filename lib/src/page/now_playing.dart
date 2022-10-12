import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/services/assets.dart';

import '../config/env.dart';
import '../controller/nowPlaying_controller.dart';
import '../services/themes.dart';
import '../services/utils.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final NowPlayingController playing = Get.put(NowPlayingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text("Now Playing"),
        ),
        body: Container(
          child: Obx(() {
            if (playing.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      child: GridView.builder(
                          controller: playing.scrollController,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                              ((width(context) / 2) / 260),
                              crossAxisCount: 2),
                          shrinkWrap: true,
                          itemCount: playing.playing.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0)),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      // if (productController
                                      //     .produk[index].active ==
                                      //     true) {
                                      //   Get.toNamed(detailprodukRoute,
                                      //       arguments: [
                                      //         productController
                                      //             .produk[index].id
                                      //             .toString(),
                                      //         productController
                                      //             .produk[index].name
                                      //       ]);
                                      // } else {
                                      //   null;
                                      // }
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      child: playing
                                          .playing[index]
                                          .posterPath ==
                                          null
                                          ? Image.asset(
                                        noImage,
                                        width:
                                        width(context) /
                                            2,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      )
                                          : SizedBox(
                                        width:
                                        width(context) /
                                            2,
                                        height: 180,
                                        child: Image.network(
                                          BASE_URL_IMAGE +
                                              "/${playing.playing[index].posterPath}",
                                          width:
                                          width(context) /
                                              2,
                                          height: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 20),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(right: 12),
                                      child: Text(
                                        playing
                                            .playing[index].title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color:Colors.black
                                                    )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width:width(context)/2-60,
                                    child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(playing.playing[index].releaseDate??"-"))}"),
                                  )
                                ],
                              ),
                            );
                          })),
                  playing.isLoadingPage.value
                      ? Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ))
                      : Container(),
                ],
              );
            }
          }),
        ));
  }
}
