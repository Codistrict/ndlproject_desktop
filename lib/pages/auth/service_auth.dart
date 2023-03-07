// ignore_for_file: todo
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ndlproject_desktop/global_var.dart';

class ServicesAuth {
  Future getAuth(username, password) async {
    final response = await http.get(
      Uri.parse("${pathAPI}login?username=$username&password=$password"),
    );
    if (response.statusCode == 200) {
      var respStatus = json.decode(response.body)['status'];
      var respMessage = json.decode(response.body)['message'];
      var respData = json.decode(response.body)['data'];
      return [respStatus, respMessage, respData];
    } else {
      throw Exception("Gagal Mengambil Data");
    }
  }
}
