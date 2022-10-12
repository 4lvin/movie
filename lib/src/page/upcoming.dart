import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/config/env.dart';
import 'package:movies/src/controller/upcoming_controller.dart';
import 'package:movies/src/services/utils.dart';

import '../services/assets.dart';
import '../services/themes.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  final UpcomingController upcoming = Get.put(UpcomingController());
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
            title: Text("Upcoming")
        ),
        body: Container(
          child: Obx(() {
            if (upcoming.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      child: GridView.builder(
                          controller: upcoming.scrollController,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                              ((width(context) / 2) / 260),
                              crossAxisCount: 2),
                          shrinkWrap: true,
                          itemCount: upcoming.upcoming.length,
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
                                      child: upcoming
                                          .upcoming[index]
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
                                              "/${upcoming.upcoming[index].posterPath}",
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
                                        upcoming
                                            .upcoming[index].title!,
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
                                    child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(upcoming.upcoming[index].releaseDate??"-"))}"),
                                  )
                                ],
                              ),
                            );
                          })),
                  upcoming.isLoadingPage.value
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
