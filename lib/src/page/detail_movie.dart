import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/src/config/env.dart';
import 'package:movies/src/controller/detail_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/assets.dart';
import '../services/themes.dart';
import '../services/utils.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({Key? key}) : super(key: key);

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  final DetailController detail = Get.put(DetailController());

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Obx(() {
          if (detail.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: detail.detail.value.backdropPath == null
                              ? Image.asset(
                                  noImage,
                                  width: width(context) / 2 - 20,
                                  height: 220,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  BASE_URL_IMAGE + "/${detail.detail.value.backdropPath}",
                                  width: width(context),
                                  height: height(context) / 2 - 100,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Column(
                          children: [
                            Container(
                                height: height(context) / 2 - 150,
                                child: Center(
                                    child: Text(
                                  detail.detail.value.originalTitle ?? "-",
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ))),
                            Container(
                              padding: EdgeInsets.all(12),
                              width: width(context) - 50,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width(context) - 70,
                                      child: Text(
                                        "Trailer",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        textAlign: TextAlign.start,
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                      height: 190,
                                      width: width(context) - 70,
                                      child: WebView(
                                        initialUrl: 'https://thelostcity.movie/videos/',
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              width: width(context) - 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(detail.detail.value.overview ?? "-"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Release Date",
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  Text(Utils.dateFormatddMMMyyyy(DateTime.parse(detail.detail.value.releaseDate?? "-"))),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Budget",
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(Utils.getCurrency(detail.detail.value.budget!.toDouble())),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Genres",
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      for (int i = 0; i < detail.detail.value.genres!.length; i++) ...[
                                        Container(
                                            margin: EdgeInsets.only(right: 3),
                                            padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                                            child: Text(
                                              "${detail.detail.value.genres?[i].name} ",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }));
  }
}
