// ignore_for_file: todo
import 'package:flutter/material.dart';
import 'package:ndlproject_desktop/pages/auth/service_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global_var.dart';

class LoginRegisPage extends StatefulWidget {
  const LoginRegisPage({super.key});

  @override
  State<LoginRegisPage> createState() => _LoginRegisPageState();
}

class _LoginRegisPageState extends State<LoginRegisPage> {
  ServicesAuth servicesAuth = ServicesAuth();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future getAuthPref(username, password) async {
    var response = await servicesAuth.getAuth(username, password);
    final prefs = await SharedPreferences.getInstance();

    if (response[0] != 404) {
      userStatus = true;
      userID = "";
      await prefs.setBool('userStatus', userStatus);
      await prefs.setString('userID', userID);

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
