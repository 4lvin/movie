import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/config/env.dart';
import 'package:movies/src/controller/topRate_controller.dart';
import 'package:movies/src/services/assets.dart';

import '../services/themes.dart';
import '../services/utils.dart';

class TopRate extends StatefulWidget {
  const TopRate({Key? key}) : super(key: key);

  @override
  State<TopRate> createState() => _TopRateState();
}

class _TopRateState extends State<TopRate> {
  final TopRateController topRate = Get.put(TopRateController());
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
            title: Text("Top Rate")
        ),
        body: Container(
          child: Obx(() {
            if (topRate.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      child: GridView.builder(
                          controller: topRate.scrollController,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                              ((width(context) / 2) / 260),
                              crossAxisCount: 2),
                          shrinkWrap: true,
                          itemCount: topRate.topRate.length,
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
                                      child: topRate
                                          .topRate[index]
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
                                              "/${topRate.topRate[index].posterPath}",
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
                                        topRate
                                            .topRate[index].title!,
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
                                    child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(topRate.topRate[index].releaseDate??"-"))}"),
                                  )
                                ],
                              ),
                            );
                          })),
                  topRate.isLoadingPage.value
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
