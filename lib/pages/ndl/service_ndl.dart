// ignore_for_file: todo
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndlproject_desktop/global_var.dart';

class ServicesNDL {
  // Upload file Excel + Read Response
  Future readExcel(file) async {
    var url = Uri.parse("$pathAPI/NDL/read-excel");
    final request = http.MultipartRequest('POST', url)
      ..files.add(
        await http.MultipartFile.fromPath('photo', file),
      );
    final response = await request.send();
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      var jsonRespStatus = json.decode(res.body)['status'];
      var jsonRespMessage = json.decode(res.body)['message'];
      var jsonRespData = json.decode(res.body)['data'];
      return [jsonRespStatus, jsonRespMessage, jsonRespData];
    } else {
      throw Exception("Failed to POST data");
    }
  }

  // Konfirmasi Upload Excel
  Future inputNDL(status) async {
    var url = Uri.parse("$pathAPI/NDL/input-ndl");
    final response = await http.post(url, body: {
      "status": status,
    });
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespMessage = json.decode(response.body)['message'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespMessage, jsonRespData];
    } else {
      throw Exception("Failed to POST data");
    }
  }

  // Read data NDL
  Future readNDL(page) async {
    var url = Uri.parse("$pathAPI/NDL/NDL?page=$page");
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

  // Jumlah Page NDL
  Future pageCount() async {
    var url = Uri.parse("$pathAPI/NDL/page-ndl");
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

  // Read NDL List Detail sesuai WS NO
  Future readWsnoDetail(wsno) async {
    var url = Uri.parse("$pathAPI/NDL/Read-NDL-wsno?ws_no=$wsno");
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

  Future updateWsnoDetail(
      wsNo,
      tambahDataTanggal,
      customerDeliveryDate,
      jobDone,
      orderStatus,
      cylinderStatus,
      gol,
      cust,
      itemName,
      model,
      up,
      repeatNdl,
      toleransi,
      orderNdl,
      layer,
      detailLayer) async {
    var url = Uri.parse("$pathAPI/NDL/update-ndl");
    final response = await http.put(url, body: {
      'ws_no': wsNo,
      'tambah_data_tanggal': tambahDataTanggal,
      'customer_delivery_date': customerDeliveryDate,
      'job_done': jobDone,
      'order_status': orderStatus,
      'cylinder_status': cylinderStatus,
      'gol': gol,
      'cust': cust,
      'item_name': itemName,
      'model': model,
      'up': up,
      'repeat_ndl': repeatNdl,
      'toleransi': toleransi,
      'order_ndl': orderNdl,
      'layer': layer,
      'detail_layer': detailLayer,
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
