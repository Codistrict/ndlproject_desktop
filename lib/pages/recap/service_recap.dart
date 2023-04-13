// ignore_for_file: todo
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndlproject_desktop/global_var.dart';

class ServicesRecap {
  // Read data NDL
  Future readRecap(page) async {
    var url = Uri.parse("$pathAPI/Rekap/Rekap?page=$page");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespMessage, jsonRespData];
    } else {
      throw Exception("Failed to GET data");
    }
  }

  Future updateStatusRecap(wsNo, statusRkp) async {
    var url = Uri.parse("$pathAPI/Rekap/update-status-rkp");
    final response = await http.put(url, body: {
      'ws_no': wsNo,
      'status_rekap': statusRkp,
    });

    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespMessage, jsonRespData];
    } else {
      throw Exception("Failed to PUT data");
    }
  }
}
