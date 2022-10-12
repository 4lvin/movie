import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/src/router/constant.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            buildDrawerHeader(),
            Divider(
              color: Colors.grey,
            ),
            buildDrawerItem(
              icon: Icons.home_rounded,
              text: "Home",
              onTap: () => navigate(0),
              tileColor: Get.currentRoute == rootRoute ? Colors.blue : null,
              textIconColor: Get.currentRoute == rootRoute
                  ? Colors.white
                  : Colors.black,
            ),
            buildDrawerItem(
              icon: Icons.play_circle_outline,
              text: "Now Playing",
              onTap: () => navigate(1),
              tileColor: Get.currentRoute == nowPlayingRoute ? Colors.blue : null,
              textIconColor: Get.currentRoute == nowPlayingRoute
                  ? Colors.white
                  : Colors.black,
            ),
            buildDrawerItem(
                icon: Icons.local_attraction_outlined,
                text: "Top Rated",
                onTap: () => navigate(2),
                tileColor: Get.currentRoute == topRateRoute ? Colors.blue : null,
                textIconColor: Get.currentRoute == topRateRoute
                    ? Colors.white
                    : Colors.black),
            buildDrawerItem(
                icon: Icons.ondemand_video,
                text: "Up Coming",
                onTap: () => navigate(2),
                tileColor: Get.currentRoute == upcomingRoute ? Colors.blue : null,
                textIconColor: Get.currentRoute == upcomingRoute
                    ? Colors.white
                    : Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text("Movie Pro"),
      accountEmail: Text(""),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('image/logo.jpg'),
      ),
      otherAccountsPicturesSize: Size.square(50),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(
        text,
        style: TextStyle(color: textIconColor),
      ),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

  navigate(int index) {
    if (index == 0) {
      Get.toNamed(rootRoute);
    }
    else if (index == 1) {
      Get.toNamed(nowPlayingRoute);
    }
    if (index == 2) {
      Get.toNamed(topRateRoute);
    }
    if (index == 3) {
      Get.toNamed(upcomingRoute);
    }
  }
}