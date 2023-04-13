// ignore_for_file: todo
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ndlproject_desktop/pages/ndl/service_ndl.dart';
import 'package:ndlproject_desktop/pages/widgets/confirmdialog.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../widgets/floatingactionwidget.dart';

ServicesNDL _servicesNDL = ServicesNDL();

class AdminControllerNdlPage extends StatefulWidget {
  const AdminControllerNdlPage({Key? key}) : super(key: key);

  @override
  State<AdminControllerNdlPage> createState() => _AdminControllerNdlPageState();
}

class _AdminControllerNdlPageState extends State<AdminControllerNdlPage> {
  final _controllerPageNdl = PageController();
  final _controllerPageNdlEdit = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerPageNdl.dispose();
    _controllerPageNdlEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controllerPageNdl,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        NdlPage(controllerPageNdl: _controllerPageNdl),
        EditNdlPage(controllerPageNdlEdit: _controllerPageNdl)
      ],
    );
  }
}

class NdlPage extends StatefulWidget {
  final PageController controllerPageNdl;
  const NdlPage({required this.controllerPageNdl, super.key});

  @override
  State<NdlPage> createState() => _NdlPageState();
}

class _NdlPageState extends State<NdlPage> {
  int numberOfPage = 100;
  int currentPage = 0;

  DateTime _selectedDate = DateTime.now();
  String _formattedDate = "";
  String _date = "Date";

  late Future ndlList;

  @override
  void initState() {
    super.initState();
    ndlList = _servicesNDL.readNDL(1);
  }

  Future<void> selectFilterDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff13293D), // header background color
                onPrimary: lightText, // header text color
                onSurface: darkText, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff13293D), // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate) {
      if (mounted) {
        _selectedDate = picked;
        _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
        _date = _formattedDate;

        setState(() {});
      }
    }
  }

  _showFilter(dw, dh) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ScrollController(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: TextView(
                              val: "Filter Tanggal",
                              color: darkText,
                              size: 25,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          height: 20,
                          color: darkText,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                val: "Masukkan Tanggal",
                                color: darkText,
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                              const SizedBox(height: 13),
                              SizedBox(
                                width: dw * 0.5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: darkText,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(9),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextView(
                                          val: _date,
                                          color: darkText,
                                          size: 15,
                                          weight: FontWeight.w600,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              selectFilterDate(context);
                                            },
                                            child: const Icon(
                                                Icons.calendar_month)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 55, vertical: 22),
                                      backgroundColor: navButtonThird,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const TextView(
                                      val: "Submit",
                                      color: lightText,
                                      size: 15,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 55, vertical: 22),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      side: const BorderSide(
                                          width: 2, // the thickness
                                          color:
                                              colorThird // the color of the border
                                          ),
                                    ),
                                    child: const TextView(
                                      val: "Batal",
                                      color: colorThird,
                                      size: 15,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showFilter(deviceWidth, deviceHeight);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.filter_alt_rounded,
                              size: 30,
                            ),
                            SizedBox(width: 5),
                            TextView(
                              val: "Filter",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: FutureBuilder(
                        future: ndlList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List snapData = snapshot.data! as List;
                            if (snapData[0] != 404) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      controller: ScrollController(),
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        border: TableBorder.all(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        headingRowHeight: 50,
                                        dataRowHeight: 50,
                                        columns: [
                                          datCol("Tambahkan Data Tgl"),
                                          datCol("Customer Delivery Date"),
                                          datCol("Job Done"),
                                          datCol("Durasi"),
                                          datCol("Analyzer Version"),
                                          datCol("Order Status (New/Repeat)"),
                                          datCol("Cylinder Status"),
                                          datCol("Gol"),
                                          datCol("WS No"),
                                          datCol("Customer"),
                                          datCol("Item Nama"),
                                          datCol("Model"),
                                          datCol("Up"),
                                          datCol("Repeat"),
                                          datCol("Toleransi"),
                                          datCol("Order"),
                                          datCol("W/S Order (m)"),
                                          datCol("Width"),
                                          datCol("Length"),
                                          datCol("Gusset"),
                                          datCol("prod.size"),
                                          datCol("W"),
                                          datCol("C"),
                                          datCol("Color"),
                                          datCol("1st Layer"),
                                          datCol("Width1"),
                                          datCol("RM"),
                                          datCol("Diff"),
                                          datCol("2nd Layer"),
                                          datCol("Width1"),
                                          datCol("RM"),
                                          datCol("Diff"),
                                          datCol("3nd Layer"),
                                          datCol("Width1"),
                                          datCol("RM"),
                                          datCol("Diff"),
                                          datCol("4nd Layer"),
                                          datCol("Width1"),
                                          datCol("RM"),
                                          datCol("Diff"),
                                          datCol("5nd Layer"),
                                          datCol("Width1"),
                                          datCol("RM"),
                                          datCol("Diff"),
                                          datCol("6nd Layer"),
                                          datCol("Width1"),
                                          datCol("RM"),
                                          datCol("Diff"),
                                          datCol("1st Layer"),
                                          datCol("Ink"),
                                          datCol("adh1"),
                                          datCol("2nd Layer"),
                                          datCol("adh2"),
                                          datCol("3nd Layer"),
                                          datCol("adh3"),
                                          datCol("4nd Layer"),
                                          datCol("adh4"),
                                          datCol("5nd Layer"),
                                          datCol("adh5"),
                                          datCol("6nd Layer"),
                                          datCol("Total"),
                                          //datCol("Aksi"),
                                        ],
                                        rows: List.generate(
                                          snapData[2].length,
                                          (index) {
                                            return DataRow(
                                              cells: [
                                                datRow1(
                                                    snapData[2][index]
                                                        ['tambah_data_tanggal'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index][
                                                        'customer_delivery_date'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['job_done'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['durasi'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['analyzer_version'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['order_status'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['cylider_status'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]['gol'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]['ws_no'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]['cust'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['item_name'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]['model'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]['up'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['repeat_ndl'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['toleransi'],
                                                    2,
                                                    context),
                                                datRow2(
                                                    snapData[2][index]
                                                        ['order_ndl'][0],
                                                    snapData[2][index]
                                                        ['order_ndl'][1],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['w_s_order'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]['width'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lenght'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['gusset'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['prod_size'],
                                                    2,
                                                    context),
                                                datRow1(snapData[2][index]['w'],
                                                    2, context),
                                                datRow1(snapData[2][index]['c'],
                                                    2, context),
                                                datRow1(
                                                    snapData[2][index]['color'],
                                                    2,
                                                    context),
                                                // Layer 1
                                                datRow4(
                                                    snapData[2][index]
                                                        ['layer_datail1'][0],
                                                    snapData[2][index]
                                                        ['layer_datail2'][0],
                                                    snapData[2][index]
                                                        ['layer_datail3'][0],
                                                    snapData[2][index]
                                                        ['layer_datai4'][0],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['width_layer'][0],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['rm_layer'][0],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['diff_layer'][0],
                                                    2,
                                                    context),

                                                // Layer 2
                                                datRow4(
                                                    snapData[2][index]
                                                        ['layer_datail1'][1],
                                                    snapData[2][index]
                                                        ['layer_datail2'][1],
                                                    snapData[2][index]
                                                        ['layer_datail3'][1],
                                                    snapData[2][index]
                                                        ['layer_datai4'][1],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['width_layer'][1],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['rm_layer'][1],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['diff_layer'][1],
                                                    2,
                                                    context),

                                                // Layer 3
                                                datRow4(
                                                    snapData[2][index]
                                                        ['layer_datail1'][2],
                                                    snapData[2][index]
                                                        ['layer_datail2'][2],
                                                    snapData[2][index]
                                                        ['layer_datail3'][2],
                                                    snapData[2][index]
                                                        ['layer_datai4'][2],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['width_layer'][2],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['rm_layer'][2],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['diff_layer'][2],
                                                    2,
                                                    context),

                                                // Layer 4
                                                datRow4(
                                                    snapData[2][index]
                                                        ['layer_datail1'][3],
                                                    snapData[2][index]
                                                        ['layer_datail2'][3],
                                                    snapData[2][index]
                                                        ['layer_datail3'][3],
                                                    snapData[2][index]
                                                        ['layer_datai4'][3],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['width_layer'][3],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['rm_layer'][3],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['diff_layer'][3],
                                                    2,
                                                    context),
                                                // Layer 5
                                                datRow4(
                                                    snapData[2][index]
                                                        ['layer_datail1'][4],
                                                    snapData[2][index]
                                                        ['layer_datail2'][4],
                                                    snapData[2][index]
                                                        ['layer_datail3'][4],
                                                    snapData[2][index]
                                                        ['layer_datai4'][4],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['width_layer'][4],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['rm_layer'][4],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['diff_layer'][4],
                                                    2,
                                                    context),
                                                // Layer 6
                                                datRow4(
                                                    snapData[2][index]
                                                        ['layer_datail1'][5],
                                                    snapData[2][index]
                                                        ['layer_datail2'][5],
                                                    snapData[2][index]
                                                        ['layer_datail3'][5],
                                                    snapData[2][index]
                                                        ['layer_datai4'][5],
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['width_layer'][5],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['rm_layer'][5],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['diff_layer'][5],
                                                    2,
                                                    context),

                                                // After Layer
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lyr_layer'][0],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['ink_layer'],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['adh_layer'][0],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lyr_layer'][1],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['adh_layer'][1],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lyr_layer'][2],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['adh_layer'][2],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lyr_layer'][3],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['adh_layer'][3],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lyr_layer'][4],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['adh_layer'][4],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['lyr_layer'][5],
                                                    2,
                                                    context),
                                                datRow1(
                                                    snapData[2][index]
                                                        ['total_layer'],
                                                    2,
                                                    context),
                                                //datRow3(2, context)
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataTable(
                                    border: TableBorder(
                                        top: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                        bottom: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                        horizontalInside: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid)),
                                    headingRowHeight: 50,
                                    dataRowHeight: 50,
                                    columns: [
                                      datCol("Aksi"),
                                    ],
                                    rows: List.generate(
                                      snapData[2].length,
                                      (index) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      widget.controllerPageNdl
                                                          .animateToPage(1,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          250),
                                                              curve:
                                                                  Curves.ease);
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: darkText,
                                                            width: 0.4,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 40,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {
                                                      debugPrint("Tekan");
                                                      showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        useRootNavigator: true,
                                                        context: context,
                                                        builder: (context) {
                                                          return ConfirmDialog(
                                                            titleText:
                                                                "Apakah anda yakin ingin menghapus baris ini?",
                                                            confirmText:
                                                                "Ya, hapus",
                                                            declineText:
                                                                "Tidak, jangan hapus",
                                                            confirmFunc: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            declineFunc: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: darkText,
                                                            width: 0.4,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 40,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //datRow3(2, context)
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapData[0] == 404) {
                              return Container();
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: deviceWidth / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: NumberPaginator(
                          initialPage: 0,
                          config: const NumberPaginatorUIConfig(
                            buttonSelectedForegroundColor: lightText,
                            buttonUnselectedForegroundColor: darkText,
                            buttonSelectedBackgroundColor: secondaryColor,
                          ),
                          numberPages: numberOfPage,
                          onPageChange: (index) {
                            setState(() {
                              currentPage = index;
                              ndlList = _servicesNDL.readNDL(currentPage + 1);
                              debugPrint(currentPage.toString());
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFAB(
        icon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(
                Icons.download,
                color: primaryColor,
              ),
              backgroundColor: secondaryColor,
              onTap: () {},
              label: 'Download',
              labelStyle: GoogleFonts.inter(
                fontSize: 16,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
              labelBackgroundColor: secondaryColor),
          // FAB 2
          SpeedDialChild(
              child: const Icon(
                Icons.upload,
                color: primaryColor,
              ),
              backgroundColor: secondaryColor,
              onTap: () async {
                FilePickerResult? result;
                result = await FilePicker.platform.pickFiles();
                String file;
                if (result != null) {
                  file = result.files.single.path.toString();
                  Navigator.push(
                    this.context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmNDL(
                        file: file,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: TextView(val: "Gagal Mengambil File"),
                    ),
                  );
                }
              },
              label: 'Upload',
              labelStyle: GoogleFonts.inter(
                fontSize: 16,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
              labelBackgroundColor: secondaryColor),
        ],
      ),
    );
  }
}

class EditNdlPage extends StatefulWidget {
  final PageController controllerPageNdlEdit;
  const EditNdlPage({required this.controllerPageNdlEdit, super.key});

  @override
  State<EditNdlPage> createState() => _EditNdlPageState();
}

class _EditNdlPageState extends State<EditNdlPage> {
  DateTime _selectedDate1 = DateTime.now();
  String _formattedDate1 = "";
  String _date1 = "";

  DateTime _selectedDate2 = DateTime.now();
  String _formattedDate2 = "";
  String _date2 = "";

  final FocusNode myFocusNode0 = FocusNode();
  final FocusNode myFocusNode = FocusNode();
  final FocusNode myFocusNode2 = FocusNode();
  final FocusNode myFocusNode3 = FocusNode();
  final FocusNode myFocusNode4 = FocusNode();
  final FocusNode myFocusNode5 = FocusNode();
  final FocusNode myFocusNode6 = FocusNode();
  final FocusNode myFocusNode7 = FocusNode();
  final FocusNode myFocusNode8 = FocusNode();
  final FocusNode myFocusNode9 = FocusNode();
  final FocusNode myFocusNode10 = FocusNode();
  final FocusNode myFocusNode11 = FocusNode();
  final FocusNode myFocusNode12 = FocusNode();
  final FocusNode myFocusNode13 = FocusNode();
  final FocusNode myFocusNode14 = FocusNode();
  final FocusNode myFocusNode15 = FocusNode();
  final FocusNode myFocusNode16 = FocusNode();
  final FocusNode myFocusNode17 = FocusNode();
  final FocusNode myFocusNode18 = FocusNode();
  final FocusNode myFocusNode19 = FocusNode();
  final FocusNode myFocusNode20 = FocusNode();
  final FocusNode myFocusNode21 = FocusNode();
  final FocusNode myFocusNode22 = FocusNode();
  final FocusNode myFocusNode23 = FocusNode();
  final FocusNode myFocusNode24 = FocusNode();
  final FocusNode myFocusNodeUp = FocusNode();

  // void dispose() {
  //   focusNode.dispose();
  //   super.dispose();
  // }

  void _jumToWidget(focusKirim) {
    FocusScope.of(context).requestFocus(focusKirim);
  }

  Future<void> selectFilterDate1(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate1,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff13293D),
                onPrimary: lightText,
                onSurface: darkText,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xff13293D), // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate1) {
      if (mounted) {
        _selectedDate1 = picked;
        _formattedDate1 = DateFormat('dd-MM-yyyy').format(_selectedDate1);
        _date1 = _formattedDate1;

        setState(() {});
      }
    }
  }

  Future<void> selectFilterDate2(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate2,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff13293D),
                onPrimary: lightText,
                onSurface: darkText,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xff13293D), // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate2) {
      if (mounted) {
        _selectedDate2 = picked;
        _formattedDate2 = DateFormat('dd-MM-yyyy').format(_selectedDate2);
        _date2 = _formattedDate2;

        setState(() {});
      }
    }
  }

  final _controllerNamaBarangTambahPenjualan = TextEditingController();
  final List<String> _namaStockArray = [
    "Job Done",
    "Order Status",
    "Cylinder Status",
    "Gol",
    "Nama Customer",
    "Nama Item",
    "Model",
    "Up",
    "Repeat",
    "Toleransi",
    "Order Masuk",
    "Layer 1",
    "Layer 2",
    "Layer 3",
    "Layer 4",
    "Layer 5",
    "Layer 6"
  ];

  int indexTambah = 1;

  @override
  void initState() {
    // TODO: implement initState
    _controllerNamaBarangTambahPenjualan.addListener(() {
      setState(() {
        //_getStockTemp();
      });
    });
    super.initState();
  }

  Future searchData(String param) async {
    List<String> result = _namaStockArray
        .where((Element) => Element.toLowerCase().contains(param.toLowerCase()))
        .toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _jumToWidget(myFocusNodeUp);
          });
        },
        backgroundColor: secondaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Icon(
          Icons.arrow_upward_outlined,
          color: primaryColor,
        ),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  val: "Ws No : 0001",
                  color: darkText,
                  size: 18,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 20),
                const TextView(
                  val: "Pilih Kolom Yang Ingin Di Edit",
                  color: darkText,
                  size: 15,
                  weight: FontWeight.w600,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: myFocusNodeUp,
                          controller: _controllerNamaBarangTambahPenjualan,
                          autofocus: false,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: lightText,
                            hintText: 'Pilih Kolom Edit',
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: darkText,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: darkText,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: darkText,
                              ),
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await searchData(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (String suggestion) {
                          _controllerNamaBarangTambahPenjualan.text =
                              suggestion;
                          setState(() {
                            if (suggestion == "Job Done") {
                              _jumToWidget(myFocusNode);
                            }
                            if (suggestion == "Analyzer Version") {
                              _jumToWidget(myFocusNode2);
                            }
                            if (suggestion == "Order Status") {
                              _jumToWidget(myFocusNode3);
                            }
                            if (suggestion == "Cylinder Status") {
                              _jumToWidget(myFocusNode4);
                            }
                            if (suggestion == "Gol") {
                              _jumToWidget(myFocusNode5);
                            }
                            if (suggestion == "Nama Customer") {
                              _jumToWidget(myFocusNode6);
                            }
                            if (suggestion == "Nama Item") {
                              _jumToWidget(myFocusNode7);
                            }
                            if (suggestion == "Model") {
                              _jumToWidget(myFocusNode8);
                            }
                            if (suggestion == "Up") {
                              _jumToWidget(myFocusNode9);
                            }
                            if (suggestion == "Repeat") {
                              _jumToWidget(myFocusNode10);
                            }
                            if (suggestion == "Toleransi") {
                              _jumToWidget(myFocusNode11);
                            }
                            if (suggestion == "Order Masuk") {
                              _jumToWidget(myFocusNode12);
                            }
                            if (suggestion == "Width") {
                              _jumToWidget(myFocusNode13);
                            }
                            if (suggestion == "Length") {
                              _jumToWidget(myFocusNode14);
                            }
                            if (suggestion == "Gusset") {
                              _jumToWidget(myFocusNode15);
                            }
                            if (suggestion == "W") {
                              _jumToWidget(myFocusNode16);
                            }
                            if (suggestion == "C") {
                              _jumToWidget(myFocusNode17);
                            }
                            if (suggestion == "Color") {
                              _jumToWidget(myFocusNode18);
                            }
                            if (suggestion == "Layer 1") {
                              _jumToWidget(myFocusNode19);
                            }
                            if (suggestion == "Layer 2") {
                              _jumToWidget(myFocusNode20);
                            }
                            if (suggestion == "Layer 3") {
                              _jumToWidget(myFocusNode21);
                            }
                            if (suggestion == "Layer 4") {
                              _jumToWidget(myFocusNode22);
                            }
                            if (suggestion == "Layer 5") {
                              _jumToWidget(myFocusNode23);
                            }
                            if (suggestion == "Layer 6") {
                              _jumToWidget(myFocusNode24);
                            }
                          });
                          print(suggestion);
                        },
                        getImmediateSuggestions: true,
                        hideSuggestionsOnKeyboardHide: false,
                        hideOnEmpty: false,
                        noItemsFoundBuilder: (context) => const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Tidak ada model"),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        // controller:
                        //     _controllerJumlahBarangTambahPenjualan,
                        showCursor: false,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          filled: false,
                          fillColor: Colors.transparent,
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: const TextView(
                              val: "Masukkan Tambah Data Tanggal",
                              color: darkText,
                              size: 15,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: darkText,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    val: _date1,
                                    color: darkText,
                                    size: 13,
                                    weight: FontWeight.w500,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        selectFilterDate1(context).whenComplete(
                                            () => setState(() {}));
                                      },
                                      child: const Icon(Icons.calendar_month)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Customer Delivery Date",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: darkText,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    val: _date2,
                                    color: darkText,
                                    size: 13,
                                    weight: FontWeight.w500,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        selectFilterDate2(context).whenComplete(
                                            () => setState(() {}));
                                      },
                                      child: const Icon(Icons.calendar_month)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Job Done",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Cylinder Status",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode4, lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Order Status (New/Repeat)",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode3, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Customer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode6, lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Gol",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode5, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Model",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode8, lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Item",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode7, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Repeat",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode10, lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Up",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode9, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Order Masuk",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode12, lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Toleransi",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode11, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const TextView(
                  val: "Layer 1",
                  color: darkText,
                  size: 22,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Layer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode19, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Ketebalan",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width 1",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan RM",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const TextView(
                  val: "Layer 2",
                  color: darkText,
                  size: 22,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Layer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode20, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Ketebalan",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width 2",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan RM",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const TextView(
                  val: "Layer 3",
                  color: darkText,
                  size: 22,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Layer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode21, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Ketebalan",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width 3",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan RM",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const TextView(
                  val: "Layer 4",
                  color: darkText,
                  size: 22,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Layer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode22, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Ketebalan",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width 4",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan RM",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const TextView(
                  val: "Layer 5",
                  color: darkText,
                  size: 22,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Layer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode23, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Ketebalan",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width 5",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan RM",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const TextView(
                  val: "Layer 6",
                  color: darkText,
                  size: 22,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Nama Layer",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa2(myFocusNode24, lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Ketebalan",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan Width 6",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "Masukkan RM",
                            color: darkText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldYa3(lightText),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            val: "",
                            color: lightText,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            showCursor: false,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              fillColor: lightText,
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: lightText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.controllerPageNdlEdit.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: BorderSide(
                              width: 2, // the thickness
                              color: colorThird // the color of the border
                              )),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back_outlined, color: colorThird),
                          SizedBox(width: 5),
                          TextView(
                            val: "Back",
                            color: colorThird,
                            size: 15,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 22),
                        primary: Colors.white,
                        backgroundColor: navButtonThird,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: const TextView(
                        val: "Simpan",
                        color: lightText,
                        size: 15,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Page isi dari upload Excel
class ConfirmNDL extends StatefulWidget {
  final String file;
  const ConfirmNDL({
    super.key,
    required this.file,
  });

  @override
  State<ConfirmNDL> createState() => _ConfirmNDLState();
}

class _ConfirmNDLState extends State<ConfirmNDL> {
  late Future ndlList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ndlList = _servicesNDL.readExcel(widget.file);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
                child: FutureBuilder(
                  future: ndlList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List snapData = snapshot.data! as List;
                      if (snapData[0] != 404) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  border: TableBorder.all(
                                    color: Colors.black.withOpacity(0.5),
                                    style: BorderStyle.solid,
                                  ),
                                  headingRowHeight: 50,
                                  dataRowHeight: 50,
                                  columns: [
                                    datCol("Tambahkan Data Tgl"),
                                    datCol("Customer Delivery Date"),
                                    datCol("Job Done"),
                                    datCol("Durasi"),
                                    datCol("Analyzer Version"),
                                    datCol("Order Status (New/Repeat)"),
                                    datCol("Cylinder Status"),
                                    datCol("Gol"),
                                    datCol("WS No"),
                                    datCol("Customer"),
                                    datCol("Item Nama"),
                                    datCol("Model"),
                                    datCol("Up"),
                                    datCol("Repeat"),
                                    datCol("Toleransi"),
                                    datCol("Order"),
                                    datCol("W/S Order (m)"),
                                    datCol("Width"),
                                    datCol("Length"),
                                    datCol("Gusset"),
                                    datCol("prod.size"),
                                    datCol("W"),
                                    datCol("C"),
                                    datCol("Color"),
                                    datCol("1st Layer"),
                                    datCol("Width1"),
                                    datCol("RM"),
                                    datCol("Diff"),
                                    datCol("2nd Layer"),
                                    datCol("Width1"),
                                    datCol("RM"),
                                    datCol("Diff"),
                                    datCol("3nd Layer"),
                                    datCol("Width1"),
                                    datCol("RM"),
                                    datCol("Diff"),
                                    datCol("4nd Layer"),
                                    datCol("Width1"),
                                    datCol("RM"),
                                    datCol("Diff"),
                                    datCol("5nd Layer"),
                                    datCol("Width1"),
                                    datCol("RM"),
                                    datCol("Diff"),
                                    datCol("6nd Layer"),
                                    datCol("Width1"),
                                    datCol("RM"),
                                    datCol("Diff"),
                                    datCol("1st Layer"),
                                    datCol("Ink"),
                                    datCol("adh1"),
                                    datCol("2nd Layer"),
                                    datCol("adh2"),
                                    datCol("3nd Layer"),
                                    datCol("adh3"),
                                    datCol("4nd Layer"),
                                    datCol("adh4"),
                                    datCol("5nd Layer"),
                                    datCol("adh5"),
                                    datCol("6nd Layer"),
                                    datCol("Total"),
                                    //datCol("Aksi"),
                                  ],
                                  rows: List.generate(
                                    snapData[2].length,
                                    (index) {
                                      return DataRow(
                                        cells: [
                                          datRow1(
                                              snapData[2][index]
                                                  ['tambah_data_tanggal'],
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]
                                                  ['customer_delivery_date'],
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['job_done'],
                                              2,
                                              context),
                                          datRow1(snapData[2][index]['durasi'],
                                              2, context),
                                          datRow1(
                                              snapData[2][index]
                                                  ['analyzer_version'],
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]
                                                  ['order_status'],
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]
                                                  ['cylider_status'],
                                              2,
                                              context),
                                          datRow1(snapData[2][index]['gol'], 2,
                                              context),
                                          datRow1(snapData[2][index]['ws_no'],
                                              2, context),
                                          datRow1(snapData[2][index]['cust'], 2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['item_name'],
                                              2,
                                              context),
                                          datRow1(snapData[2][index]['model'],
                                              2, context),
                                          datRow1(snapData[2][index]['up'], 2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['repeat_ndl'],
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['toleransi'],
                                              2,
                                              context),
                                          datRow2(
                                              snapData[2][index]['order_ndl']
                                                  [0],
                                              snapData[2][index]['order_ndl']
                                                  [1],
                                              context),
                                          datRow1(
                                              snapData[2][index]['w_s_order'],
                                              2,
                                              context),
                                          datRow1(snapData[2][index]['width'],
                                              2, context),
                                          datRow1(snapData[2][index]['lenght'],
                                              2, context),
                                          datRow1(snapData[2][index]['gusset'],
                                              2, context),
                                          datRow1(
                                              snapData[2][index]['prod_size'],
                                              2,
                                              context),
                                          datRow1(snapData[2][index]['w'], 2,
                                              context),
                                          datRow1(snapData[2][index]['c'], 2,
                                              context),
                                          datRow1(snapData[2][index]['color'],
                                              2, context),

                                          // Layer 1
                                          datRow4(
                                              snapData[2][index]['layer_datail1'].length > 0
                                                  ? snapData[2][index]
                                                      ['layer_datail1'][0]
                                                  : " ",
                                              snapData[2][index]['layer_datail2'].length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['layer_datail2'][0]
                                                  : " ",
                                              snapData[2][index]['layer_datail3']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['layer_datail3'][0]
                                                  : " ",
                                              snapData[2][index]['layer_datai4']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['layer_datai4'][0]
                                                  : " ",
                                              context),
                                          datRow1(
                                              snapData[2][index]['width_layer']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['width_layer'][0]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['rm_layer']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['rm_layer'][0]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['diff_layer']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['diff_layer'][0]
                                                  : " ",
                                              2,
                                              context),

                                          // Layer 2
                                          datRow4(
                                              snapData[2][index]['layer_datail1'].length > 1
                                                  ? snapData[2][index]
                                                      ['layer_datail1'][1]
                                                  : " ",
                                              snapData[2][index]['layer_datail2'].length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['layer_datail2'][1]
                                                  : " ",
                                              snapData[2][index]['layer_datail3']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['layer_datail3'][1]
                                                  : " ",
                                              snapData[2][index]['layer_datai4']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['layer_datai4'][1]
                                                  : " ",
                                              context),
                                          datRow1(
                                              snapData[2][index]['width_layer']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['width_layer'][1]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['rm_layer']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['rm_layer'][1]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['diff_layer']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['diff_layer'][1]
                                                  : " ",
                                              2,
                                              context),

                                          // Layer 3
                                          datRow4(
                                              snapData[2][index]['layer_datail1'].length > 2
                                                  ? snapData[2][index]
                                                      ['layer_datail1'][2]
                                                  : " ",
                                              snapData[2][index]['layer_datail2'].length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['layer_datail2'][2]
                                                  : " ",
                                              snapData[2][index]['layer_datail3']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['layer_datail3'][2]
                                                  : " ",
                                              snapData[2][index]['layer_datai4']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['layer_datai4'][2]
                                                  : " ",
                                              context),
                                          datRow1(
                                              snapData[2][index]['width_layer']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['width_layer'][2]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['rm_layer']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['rm_layer'][2]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['diff_layer']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['diff_layer'][2]
                                                  : " ",
                                              2,
                                              context),

                                          // Layer 4
                                          datRow4(
                                              snapData[2][index]['layer_datail1'].length > 3
                                                  ? snapData[2][index]
                                                      ['layer_datail1'][3]
                                                  : " ",
                                              snapData[2][index]['layer_datail2'].length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['layer_datail2'][3]
                                                  : " ",
                                              snapData[2][index]['layer_datail3']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['layer_datail3'][3]
                                                  : " ",
                                              snapData[2][index]['layer_datai4']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['layer_datai4'][3]
                                                  : " ",
                                              context),
                                          datRow1(
                                              snapData[2][index]['width_layer']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['width_layer'][3]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['rm_layer']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['rm_layer'][3]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['diff_layer']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['diff_layer'][3]
                                                  : " ",
                                              2,
                                              context),

                                          // Layer 5
                                          datRow4(
                                              snapData[2][index]['layer_datail1'].length > 4
                                                  ? snapData[2][index]
                                                      ['layer_datail1'][4]
                                                  : " ",
                                              snapData[2][index]['layer_datail2'].length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['layer_datail2'][4]
                                                  : " ",
                                              snapData[2][index]['layer_datail3']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['layer_datail3'][4]
                                                  : " ",
                                              snapData[2][index]['layer_datai4']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['layer_datai4'][4]
                                                  : " ",
                                              context),
                                          datRow1(
                                              snapData[2][index]['width_layer']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['width_layer'][4]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['rm_layer']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['rm_layer'][4]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['diff_layer']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['diff_layer'][4]
                                                  : " ",
                                              2,
                                              context),

                                          // Layer 6
                                          datRow4(
                                              snapData[2][index]['layer_datail1'].length > 5
                                                  ? snapData[2][index]
                                                      ['layer_datail1'][5]
                                                  : " ",
                                              snapData[2][index]['layer_datail2'].length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['layer_datail2'][5]
                                                  : " ",
                                              snapData[2][index]['layer_datail3']
                                                          .length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['layer_datail3'][5]
                                                  : " ",
                                              snapData[2][index]['layer_datai4']
                                                          .length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['layer_datai4'][5]
                                                  : " ",
                                              context),
                                          datRow1(
                                              snapData[2][index]['width_layer']
                                                          .length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['width_layer'][5]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['rm_layer']
                                                          .length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['rm_layer'][5]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['diff_layer']
                                                          .length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['diff_layer'][5]
                                                  : " ",
                                              2,
                                              context),

                                          // After Layer
                                          datRow1(
                                              snapData[2][index]['lyr_layer']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['lyr_layer'][0]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['ink_layer'],
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['adh_layer']
                                                          .length >
                                                      0
                                                  ? snapData[2][index]
                                                      ['adh_layer'][0]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['lyr_layer']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['lyr_layer'][1]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['adh_layer']
                                                          .length >
                                                      1
                                                  ? snapData[2][index]
                                                      ['adh_layer'][1]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['lyr_layer']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['lyr_layer'][2]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['adh_layer']
                                                          .length >
                                                      2
                                                  ? snapData[2][index]
                                                      ['adh_layer'][2]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['lyr_layer']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['lyr_layer'][3]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['adh_layer']
                                                          .length >
                                                      3
                                                  ? snapData[2][index]
                                                      ['adh_layer'][3]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['lyr_layer']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['lyr_layer'][4]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['adh_layer']
                                                          .length >
                                                      4
                                                  ? snapData[2][index]
                                                      ['adh_layer'][4]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['lyr_layer']
                                                          .length >
                                                      5
                                                  ? snapData[2][index]
                                                      ['lyr_layer'][5]
                                                  : " ",
                                              2,
                                              context),
                                          datRow1(
                                              snapData[2][index]['total_layer'],
                                              2,
                                              context),
                                          //datRow3(2, context)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (snapData[0] == 404) {
                        return Container();
                      }
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFAB(
        icon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(
                Icons.close,
                color: primaryColor,
              ),
              backgroundColor: secondaryColor,
              onTap: () {
                _servicesNDL
                    .inputNDL("")
                    .whenComplete(() => Navigator.pop(context));
              },
              label: 'Cancel',
              labelStyle: GoogleFonts.inter(
                fontSize: 16,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
              labelBackgroundColor: secondaryColor),
          SpeedDialChild(
              child: const Icon(
                Icons.check,
                color: primaryColor,
              ),
              backgroundColor: secondaryColor,
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  useRootNavigator: true,
                  context: context,
                  builder: (context) {
                    return ConfirmDialog(
                      titleText: "Data yang di upload sudah benar?",
                      confirmText: "Ya, konfirmasi",
                      declineText: "Salah, upload ulang",
                      confirmFunc: () async {
                        await _servicesNDL
                            .inputNDL("ok")
                            .whenComplete(() => Navigator.pop(context));
                      },
                      declineFunc: () async {
                        await _servicesNDL
                            .inputNDL("")
                            .whenComplete(() => Navigator.pop(context));
                      },
                    );
                  },
                ).whenComplete(() => Navigator.pop(context));
              },
              label: 'Confirm',
              labelStyle: GoogleFonts.inter(
                fontSize: 16,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
              labelBackgroundColor: secondaryColor),
        ],
      ),
    );
  }
}
