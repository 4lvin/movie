import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/commons/navigation_drawer.dart';
import 'package:movies/src/controller/nowPlaying_controller.dart';
import 'package:movies/src/controller/popular_controller.dart';
import 'package:movies/src/controller/topRate_controller.dart';
import 'package:movies/src/controller/upcoming_controller.dart';
import 'package:movies/src/services/themes.dart';

import '../config/env.dart';
import '../router/constant.dart';
import '../services/assets.dart';
import '../services/utils.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NowPlayingController playing = Get.put(NowPlayingController());
  final PopularController popular = Get.put(PopularController());
  final TopRateController topRate = Get.put(TopRateController());
  final UpcomingController comingup = Get.put(UpcomingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Text("Home"),
            Spacer(),
            Container(
              width: 235,
              height: 35,
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ThemeData()
                        .colorScheme
                        .copyWith(primary: Colors.white)),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 7),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Cari",
                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle()),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      // productController.getProduk(key: "", kategori: data);
                    } else if (value.length >= 3) {
                      // productController.resetProduk();
                      // productController.getProduk(
                      //     key: value.toLowerCase(), kategori: data);
                    }
                  },
                  onFieldSubmitted: (value) {
                    if (value.length >= 3) {
                      // productController.resetProduk();
                      // productController.getProduk(
                      //     key: value.toLowerCase(), kategori: data);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Row(
                children: [
                  Text("Now Playing",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Get.toNamed(
                          nowPlayingRoute);
                    },
                      child: Container(padding:EdgeInsets.all(8),child: Text("More")))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (playing.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: playing.playing.length < 5 ? playing.playing.length:5,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () => Get.toNamed(
                                      detailRoute,
                                      arguments: [
                                        playing.playing[index].id.toString(),
                                      ]),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    child:
                                    playing.playing[index].posterPath == null
                                        ? Image.asset(
                                      noImage,
                                      width: width(context)/2 -20,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                      BASE_URL_IMAGE +
                                          "/${playing.playing[index].posterPath}",
                                      width: width(context)/2 - 20,
                                      height: 220,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  width: width(context)/2-50,
                                  child: Text(
                                    playing.playing[index].originalTitle!,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis)),
                                  ),
                                ),
                                Container(
                                  width: width(context)/2-50,
                                  child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(playing.playing[index].releaseDate??"-"))}",style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Row(
                children: [
                  Text("Popular",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                      onTap: (){
                        Get.toNamed(
                            popularRoute);
                      },
                      child: Container(padding:EdgeInsets.all(8),child: Text("More")))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (popular.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: popular.popular.length < 5 ? popular.popular.length:5,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  // onTap: () => Get.toNamed(
                                  //     detailresepRoute,
                                  //     arguments: [
                                  //       resep.resep[index].id,
                                  //     ]),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    child:
                                    popular.popular[index].posterPath == null
                                        ? Image.asset(
                                      noImage,
                                      width: width(context)/2 -70,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                      BASE_URL_IMAGE +
                                          "/${popular.popular[index].posterPath}",
                                      width: width(context)/2 - 70,
                                      height: 180,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  width: width(context)/2-100,
                                  child: Text(
                                    popular.popular[index].originalTitle!,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis)),
                                  ),
                                ),
                                Container(
                                  width: width(context)/2-100,
                                  child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(popular.popular[index].releaseDate??"-"))}",style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Row(
                children: [
                  Text("Top Rate",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                      onTap: (){
                        Get.toNamed(
                            topRateRoute);
                      },
                      child: Container(padding:EdgeInsets.all(8),child: Text("More")))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (topRate.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: topRate.topRate.length < 5 ? topRate.topRate.length:5,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  // onTap: () => Get.toNamed(
                                  //     detailresepRoute,
                                  //     arguments: [
                                  //       resep.resep[index].id,
                                  //     ]),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    child:
                                    topRate.topRate[index].posterPath == null
                                        ? Image.asset(
                                      noImage,
                                      width: width(context)/2 -70,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                      BASE_URL_IMAGE +
                                          "/${topRate.topRate[index].posterPath}",
                                      width: width(context)/2 - 70,
                                      height: 180,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  width: width(context)/2-100,
                                  child: Text(
                                    topRate.topRate[index].originalTitle!,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis)),
                                  ),
                                ),
                                Container(
                                  width: width(context)/2-100,
                                  child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(topRate.topRate[index].releaseDate??"-"))}",style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Row(
                children: [
                  Text("Upcoming",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                      onTap: (){
                        Get.toNamed(
                            upcomingRoute);
                      },
                      child: Container(padding:EdgeInsets.all(8),child: Text("More")))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (comingup.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: comingup.upcoming.length < 5 ? comingup.upcoming.length:5,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  // onTap: () => Get.toNamed(
                                  //     detailresepRoute,
                                  //     arguments: [
                                  //       resep.resep[index].id,
                                  //     ]),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    child:
                                    comingup.upcoming[index].posterPath == null
                                        ? Image.asset(
                                      noImage,
                                      width: width(context)/2 -70,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                      BASE_URL_IMAGE +
                                          "/${comingup.upcoming[index].posterPath}",
                                      width: width(context)/2 - 70,
                                      height: 180,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  width: width(context)/2-100,
                                  child: Text(
                                    comingup.upcoming[index].originalTitle!,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis)),
                                  ),
                                ),
                                Container(
                                  width: width(context)/2-100,
                                  child: Text("${Utils.dateFormatddMMMyyyy(DateTime.parse(comingup.upcoming[index].releaseDate??"-"))}",style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
