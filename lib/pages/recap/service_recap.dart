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

  Future updateStatusRecap(wsNo, statusRkp, dperiod, comment) async {
    var url = Uri.parse("$pathAPI/Rekap/update-status-rkp");
    final response = await http.put(url, body: {
      'ws_no': wsNo,
      'status_rekap': statusRkp,
      'delivery_period': dperiod,
      'comment': comment,
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

  // InputPO
  Future inputPO(wsNo, layer, namaPo, tanggal, meter, kg, diffPc) async {
    var url = Uri.parse("$pathAPI/PO/input-PO-supplier");
    final response = await http.post(url, body: {
      "ws_no": wsNo,
      "layer": layer,
      "nama_po": namaPo,
      "tanggal": tanggal,
      "meter": meter,
      "kg": kg,
      "diff_pc": diffPc,
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

  // ReadPO
  Future readPO(wsno, layer) async {
    var url = Uri.parse("$pathAPI/PO/read-PO?ws_no=$wsno&layer=$layer");
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

  // Read Layer PO
  Future readLayerPO(wsno) async {
    var url = Uri.parse("$pathAPI/PO/read-layer-PO?ws_no=$wsno");
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
}
