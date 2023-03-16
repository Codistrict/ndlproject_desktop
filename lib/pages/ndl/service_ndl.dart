// ignore_for_file: todo
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ndlproject_desktop/global_var.dart';

class ServicesNDL {
  Future readExcel() async {
    final response = await http.post(
      Uri.parse("${pathAPI}NDL/read-excel"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespMessage, jsonRespData];
    } else {
      throw Exception("Failed to POST data");
    }
  }

  Future inputNDL() async {
    final response = await http.post(
      Uri.parse("${pathAPI}NDL/input-ndl"),
    );
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespMessage, jsonRespData];
    } else {
      throw Exception("Failed to POST data");
    }
  }
}
