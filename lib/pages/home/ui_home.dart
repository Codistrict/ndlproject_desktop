// ignore_for_file: todo
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndlproject_desktop/global_var.dart';
import 'package:ndlproject_desktop/pages/ndl/ui_ndl.dart';
import 'package:ndlproject_desktop/pages/recap/ui_recap.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controllerSideBarX =
      SidebarXController(selectedIndex: 0, extended: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerSideBarX.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff13293D),
        //diisi warna nek wes sesuai
        automaticallyImplyLeading: false,
        title: Container(
          width: 220,
          padding: const EdgeInsets.all(0),
          child: const Center(
            child: TextView(
              val: "NDL MONITOR",
              size: 24,
              weight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TextView(
                val: "Username Pengguna",
                weight: FontWeight.w300,
              ),
              TextView(val: "Emailpengguna@gmail.com")
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 14),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(360),
              ),
            ),
            child: Image.asset("lib/assets/images/defaultprofile.png"),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 42),
          ),
        ],
        elevation: 0,
      ),
      body: Row(
        children: [
          NavSideBarX(controller: controllerSideBarX),
          Expanded(
            child: Center(
              child: NavScreen(controller: controllerSideBarX),
            ),
          )
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: NavSideBarX(controller: controllerSideBarX),
    );
  }
}

class NavSideBarX extends StatelessWidget {
  final SidebarXController _controller;
  const NavSideBarX({super.key, required SidebarXController controller})
      : _controller = controller;

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    userStatus = false;
    userID = "";
    await prefs.setBool('userStatus', userStatus);
    await prefs.setString('userID', userID);
  }

  Future showLogoutDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const TextView(val: "Logout ALert"),
        content: const TextView(val: "Apakah Anda Yakin Ingin Keluar?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const TextView(
              val: "Cancel",
              color: darkText,
            ),
          ),
          TextButton(
            onPressed: () {
              signOut();
            },
            child: const TextView(
              val: "OK",
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: false,
      animationDuration: const Duration(milliseconds: 400),
      controller: _controller,
      theme: SidebarXTheme(
        decoration: const BoxDecoration(
          //diisi warna nek wes sesuai
          color: secondaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        hoverColor: scaffoldBackgroundColor.withOpacity(0.2),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          color: lightText,
          fontWeight: FontWeight.w400,
        ),
        selectedTextStyle: GoogleFonts.inter(
          fontSize: 14,
          color: darkText,
          fontWeight: FontWeight.w600,
        ),
        itemTextPadding: const EdgeInsets.symmetric(horizontal: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightText,
        ),
        iconTheme: const IconThemeData(
          color: navButtonPrimary,
          size: 24,
        ),
        selectedIconTheme: const IconThemeData(
          color: navButtonSecondary,
          size: 24,
        ),
        width: 252,
      ),
      // headerBuilder: (context, extended) => Container(),
      // headerDivider: null,
      // footerDivider: null,
      // footerBuilder: (context, extended) => Container(),
      footerItems: [
        SidebarXItem(
          icon: Icons.door_front_door,
          label: "Keluar",
          onTap: () {
            showLogoutDialog(context);
          },
        ),
      ],
      items: const [
        SidebarXItem(
          icon: Icons.library_books,
          label: "SO List",
        ),
        SidebarXItem(
          icon: Icons.library_books,
          label: "Rekapan",
        ),
      ],
    );
  }
}

class NavScreen extends StatelessWidget {
  final SidebarXController controller;
  const NavScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const AdminControllerNdlPage();
          case 1:
            return const AdminControllerRecapPage();
          case 2:
            return Container();
          default:
            return const TextView(
              val: "Halaman Tidak Tersedia",
              weight: FontWeight.w700,
              size: 32,
              color: darkText,
            );
        }
      },
    );
  }
}

// 252 sidebar, 100 appbar
