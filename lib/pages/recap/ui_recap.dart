// ignore_for_file: todo
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ndlproject_desktop/pages/recap/service_recap.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:number_paginator/number_paginator.dart';

import '../ndl/service_ndl.dart';

ServicesRecap _servicesRecap = ServicesRecap();
ServicesNDL _servicesNDL = ServicesNDL();

class AdminControllerRecapPage extends StatefulWidget {
  const AdminControllerRecapPage({Key? key}) : super(key: key);

  @override
  State<AdminControllerRecapPage> createState() =>
      _AdminControllerRecapPageState();
}

class _AdminControllerRecapPageState extends State<AdminControllerRecapPage> {
  final _controllerPageRecap = PageController();
  final _controllerPageRecapDetail = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerPageRecap.dispose();
    _controllerPageRecapDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controllerPageRecap,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        RecapPage(controllerPageRecap: _controllerPageRecap),
        DetailRecapPage(
            controllerPageRecapDetail: _controllerPageRecapDetail,
            controllerPageRecap: _controllerPageRecap)
      ],
    );
  }
}

class RecapPage extends StatefulWidget {
  final PageController controllerPageRecap;
  const RecapPage({required this.controllerPageRecap, super.key});

  @override
  State<RecapPage> createState() => _RecapPageState();
}

class _RecapPageState extends State<RecapPage> {
  int numberOfPage = 1;
  int currentPage = 0;

  late Future recapList;

  String controllerStatus = "";
  final TextEditingController controllerDPeriod = TextEditingController();
  final TextEditingController controllerComment = TextEditingController();

  @override
  void initState() {
    super.initState();
    recapList = _servicesRecap.readRecap(1);
    getPageCount();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerDPeriod.dispose();
    controllerComment.dispose();
  }

  Future getPageCount() async {
    var response = await _servicesNDL.pageCount();
    if (response[0] != 404) {
      numberOfPage = response[2]['page'];
      if (mounted) {
        setState(() {});
      }
    }
  }

  showEdit(dw, dh) {
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
                              val: "Update Rekap",
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
                                  val: "Update Status",
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
                                      child: Row(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                const TextView(
                                  val: "Update Delivery Period",
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
                                      child: Row(),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                              width: 2, // the thickness
                                              color:
                                                  colorThird // the color of the border
                                              )),
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
                            )),
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

  Future updateRecap(context, wsNo, statusRkp, dperiod, comment) async {
    var response = await _servicesRecap.updateStatusRecap(
        wsNo, statusRkp, dperiod, comment);
    if (response[0] != 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextView(val: "Berhasil Mengupdate Data"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextView(val: "Gagal Mengupdate File"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
              child: FutureBuilder(
                future: recapList,
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
                                  datCol("Date"),
                                  datCol("No WS"),
                                  datCol("Customer"),
                                  datCol("Item Name"),
                                  datCol("Order"),
                                  datCol("WS Meter"),
                                  datCol("Plant"),
                                  datCol("Delivery Periode"),
                                  datCol("Status"),
                                  datCol("Film 1 (M)"),
                                  datCol("Film 1 (KG)"),
                                  datCol("Film 2 (M)"),
                                  datCol("Film 2 (KG)"),
                                  datCol("Film 3 (M)"),
                                  datCol("Film 3 (KG)"),
                                  datCol("Film 4 (M)"),
                                  datCol("Film 4 (KG)"),
                                  datCol("Film 5 (M)"),
                                  datCol("Film 5 (KG)"),
                                  datCol("Film 6 (M)"),
                                  datCol("Film 6 (KG)"),
                                  datCol("Price 1 Diff"),
                                  datCol("Price 2 Diff"),
                                  datCol("Price 3 Diff"),
                                  datCol("Price 4 Diff"),
                                  datCol("Price 5 Diff"),
                                  datCol("Price 6 Diff"),
                                  datCol("Comment/Note"),
                                ],
                                rows: List.generate(
                                  snapData[2].length,
                                  (index) {
                                    return DataRow(
                                      cells: [
                                        datRowrRecap(
                                            snapData[2][index]['date_rekap']),
                                        // DataCell(
                                        //   TextField(
                                        //     autofocus: false,
                                        //     textInputAction: TextInputAction.next,
                                        //     onSubmitted: (String s) {
                                        //       FocusScope.of(context).unfocus();
                                        //     },
                                        //     style: GoogleFonts.inter(
                                        //       fontSize: 14,
                                        //       color: darkText,
                                        //       fontWeight: FontWeight.w500,
                                        //     ),
                                        //     textAlign: TextAlign.center,
                                        //     keyboardType: TextInputType.number,
                                        //     onChanged: (text) {},
                                        //   ),
                                        // ),
                                        datRowrRecap(
                                            snapData[2][index]['ws_no']),
                                        datRowrRecap(snapData[2][index]
                                            ['customer_name']),
                                        datRowrRecap(
                                            snapData[2][index]['item_name']),
                                        datRowrRecap(
                                            snapData[2][index]['order_rekap']),
                                        datRowrRecap(
                                            snapData[2][index]['ws_meter']),
                                        datRowrRecap(
                                            snapData[2][index]['plant']),
                                        datRowrRecap(snapData[2][index]
                                            ['delivery_period']),
                                        datRowrRecap(
                                            snapData[2][index]['status_rekap']),
                                        // Meter & Kg
                                        datRowrRecap(
                                            snapData[2][index]['meter'][0]),
                                        datRowrRecap(
                                            snapData[2][index]['kg'][0]),
                                        datRowrRecap(
                                            snapData[2][index]['meter'][1]),
                                        datRowrRecap(
                                            snapData[2][index]['kg'][1]),
                                        datRowrRecap(
                                            snapData[2][index]['meter'][2]),
                                        datRowrRecap(
                                            snapData[2][index]['kg'][2]),
                                        datRowrRecap(
                                            snapData[2][index]['meter'][3]),
                                        datRowrRecap(
                                            snapData[2][index]['kg'][3]),
                                        datRowrRecap(
                                            snapData[2][index]['meter'][4]),
                                        datRowrRecap(
                                            snapData[2][index]['kg'][4]),
                                        datRowrRecap(
                                            snapData[2][index]['meter'][5]),
                                        datRowrRecap(
                                            snapData[2][index]['kg'][5]),
                                        // Diff Price
                                        datRowrRecap(snapData[2][index]
                                            ['diff_price'][0]),
                                        datRowrRecap(snapData[2][index]
                                            ['diff_price'][1]),
                                        datRowrRecap(snapData[2][index]
                                            ['diff_price'][2]),
                                        datRowrRecap(snapData[2][index]
                                            ['diff_price'][3]),
                                        datRowrRecap(snapData[2][index]
                                            ['diff_price'][4]),
                                        datRowrRecap(snapData[2][index]
                                            ['diff_price'][5]),
                                        datRowrRecap(
                                            snapData[2][index]['comment_note']),
                                      ],
                                      onLongPress: () {
                                        widget.controllerPageRecap
                                            .animateToPage(1,
                                                duration: const Duration(
                                                    milliseconds: 250),
                                                curve: Curves.ease);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataTable(
                            border: TableBorder(
                                top: BorderSide(
                                    color: Colors.black.withOpacity(0.5)),
                                bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.5)),
                                horizontalInside: BorderSide(
                                    color: Colors.black.withOpacity(0.5),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                barrierDismissible: false,
                                                useRootNavigator: true,
                                                context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return Dialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child:
                                                            ScrollConfiguration(
                                                          behavior:
                                                              ScrollConfiguration
                                                                      .of(context)
                                                                  .copyWith(
                                                            dragDevices: {
                                                              PointerDeviceKind
                                                                  .touch,
                                                              PointerDeviceKind
                                                                  .mouse,
                                                            },
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            controller:
                                                                ScrollController(),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      15,
                                                                      0,
                                                                      0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Center(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          TextView(
                                                                        val:
                                                                            "Update Rekap",
                                                                        color:
                                                                            darkText,
                                                                        size:
                                                                            25,
                                                                        weight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 20,
                                                                    color:
                                                                        darkText,
                                                                  ),
                                                                  Container(
                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          20,
                                                                          20,
                                                                          20,
                                                                          15),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const TextView(
                                                                            val:
                                                                                "Update Status",
                                                                            color:
                                                                                darkText,
                                                                            size:
                                                                                16,
                                                                            weight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 13),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.5,
                                                                            child:
                                                                                DropdownSearch<String>(
                                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                textAlign: TextAlign.left,
                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                  filled: true,
                                                                                  fillColor: Colors.transparent,
                                                                                  iconColor: darkText,
                                                                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    borderSide: const BorderSide(
                                                                                      color: darkText,
                                                                                    ),
                                                                                  ),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    borderSide: const BorderSide(
                                                                                      color: darkText,
                                                                                    ),
                                                                                  ),
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    borderSide: const BorderSide(
                                                                                      color: darkText,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              popupProps: const PopupProps.menu(
                                                                                fit: FlexFit.loose,
                                                                                showSelectedItems: false,
                                                                                menuProps: MenuProps(backgroundColor: Color(0xffeee8f4)),
                                                                              ),
                                                                              items: const [
                                                                                "0",
                                                                                "1",
                                                                              ],
                                                                              onChanged: (val) {
                                                                                setState(() {
                                                                                  debugPrint(val);
                                                                                  controllerStatus = val.toString();
                                                                                });
                                                                              },
                                                                              selectedItem: snapData[2][index]['status_rekap'].toString(),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 25),
                                                                          const TextView(
                                                                            val:
                                                                                "Update Delivery Period",
                                                                            color:
                                                                                darkText,
                                                                            size:
                                                                                16,
                                                                            weight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 13),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.5,
                                                                            child:
                                                                                textFieldYa(
                                                                              Colors.transparent,
                                                                              controllerDPeriod,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 25),
                                                                          const TextView(
                                                                            val:
                                                                                "Update Comment",
                                                                            color:
                                                                                darkText,
                                                                            size:
                                                                                16,
                                                                            weight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 13),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.5,
                                                                            child:
                                                                                textFieldYa(
                                                                              Colors.transparent,
                                                                              controllerComment,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                40,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.white,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 22),
                                                                                  backgroundColor: navButtonThird,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  updateRecap(context, snapData[2][index]['ws_no'], controllerStatus, controllerDPeriod.text, controllerComment.text).whenComplete(() {
                                                                                    controllerComment.clear();
                                                                                    controllerDPeriod.clear();
                                                                                    controllerStatus = "";
                                                                                    recapList = _servicesRecap.readRecap(currentPage + 1).whenComplete(() => Navigator.pop(context));
                                                                                  });
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
                                                                                  controllerComment.clear();
                                                                                  controllerDPeriod.clear();
                                                                                  controllerStatus = "";
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 22),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                  side: const BorderSide(
                                                                                      width: 2, // the thickness
                                                                                      color: colorThird // the color of the border
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
                                                                      )),
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
                                              ).whenComplete(
                                                  () => setState(() {}));
                                            },
                                            child: Container(
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: darkText,
                                                    width: 0.4,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 40,
                                              child: const Center(
                                                  child: Icon(
                                                Icons.edit,
                                                size: 20,
                                              )),
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
            Center(
              child: Container(
                padding: const EdgeInsets.all(0),
                width: deviceWidth / 2,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: NumberPaginator(
                    initialPage: 0,
                    config: const NumberPaginatorUIConfig(
                      buttonSelectedForegroundColor: lightText,
                      buttonUnselectedForegroundColor: darkText,
                      buttonSelectedBackgroundColor: Color(0xff13293D),
                    ),
                    numberPages: numberOfPage,
                    onPageChange: (index) {
                      setState(() {
                        currentPage = index;
                        recapList = _servicesRecap.readRecap(currentPage + 1);
                        debugPrint(currentPage.toString());
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class DetailRecapPage extends StatefulWidget {
  final PageController controllerPageRecapDetail;
  final PageController controllerPageRecap;
  const DetailRecapPage(
      {required this.controllerPageRecapDetail,
      required this.controllerPageRecap,
      super.key});

  @override
  State<DetailRecapPage> createState() => _DetailRecapPageState();
}

class _DetailRecapPageState extends State<DetailRecapPage> {
  DateTime _selectedDateInsert = DateTime.now();
  String _formattedDateInsert = "";
  String _dateInsert = "";

  final TextEditingController controllerNamaPO = TextEditingController();
  final TextEditingController controllerMeter = TextEditingController();
  final TextEditingController controllerKg = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerLayer = TextEditingController();

  Future<void> selectFilterDateInsert(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateInsert,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff13293D),
                onPrimary: lightText,
                onSurface: darkText,
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
    if (picked != null && picked != _selectedDateInsert) {
      if (mounted) {
        _selectedDateInsert = picked;
        _formattedDateInsert =
            DateFormat('dd-MM-yyyy').format(_selectedDateInsert);
        _dateInsert = _formattedDateInsert;

        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNamaPO.dispose();
    controllerMeter.dispose();
    controllerKg.dispose();
    controllerPrice.dispose();
    controllerLayer.dispose();
  }

  Future insertPO(
      context, wsNo, layer, namaPo, tanggal, meter, kg, diffPc) async {
    var response = await _servicesRecap.inputPO(
        wsNo, layer, namaPo, tanggal, meter, kg, diffPc);

    if (response[0] != 404) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(
          content: TextView(val: "Data Berhasil Dikirim"),
        ),
      );
    } else if (response[0] == 404) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(
          content: TextView(val: "Gagal Mengirim Data"),
        ),
      );
    }
  }

  _showInsertData(context) {
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
                              val: "Insert Data",
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Layer",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 5),
                                          textFieldYa(
                                              lightText, controllerLayer),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Nama PO Supplier",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 5),
                                          textFieldYa(
                                              lightText, controllerNamaPO),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Tanggal PO Supplier",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: darkText,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(9),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextView(
                                                    val: _dateInsert,
                                                    color: darkText,
                                                    size: 13,
                                                    weight: FontWeight.w500,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        selectFilterDateInsert(
                                                                context)
                                                            .whenComplete(() =>
                                                                setState(
                                                                    () {}));
                                                      },
                                                      child: const Icon(Icons
                                                          .calendar_month)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Masukkan Mtr",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 5),
                                          textFieldYa(
                                              lightText, controllerMeter),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Masukkan Kg",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 5),
                                          textFieldYa(lightText, controllerKg),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Masukkan Price/Kg",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 5),
                                          textFieldYa(
                                              lightText, controllerPrice),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                              width: 2, // the thickness
                                              color:
                                                  colorThird // the color of the border
                                              )),
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
                            )),
                        const SizedBox(
                          height: 15,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TextView(
                              val: "SO No",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: "Item Name",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: "Material",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: "QTY",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        const SizedBox(width: 55),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TextView(
                              val: ": 0001",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: ": Ikan Laut Salmon 70g",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: ": NY/PE1",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: ": 66.000 Roll",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TextView(
                              val: "Date",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: "Internal Instruction No",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: "Customer",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: "Delivery Period",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        const SizedBox(width: 55),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TextView(
                              val: ": Monday, 02 Januari 2022",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: ": 12345",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: ": Reyner",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 5),
                            TextView(
                              val: ": 22 Januari 2022",
                              color: darkText,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: deviceHeight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // controller: ScrollController(),
                    // physics: const ClampingScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          controller: ScrollController(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tabel 1",
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          color: darkText,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 15),
                                    SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      controller: ScrollController(),
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        border: TableBorder.all(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        headingRowHeight: 30,
                                        dataRowHeight: 30,
                                        columnSpacing: 30,
                                        columns: [
                                          datColBold2("NY"),
                                          datColBold2("mtr"),
                                          datColBold2("kg"),
                                          datColBold2("price/kg"),
                                          //datCol("Aksi"),
                                        ],
                                        rows: [
                                          DataRow(
                                            cells: [
                                              datRowBold3("(W)760", 0, context),
                                              datRowBold3("15.180", 0, context),
                                              datRowBold3("201", 0, context),
                                              datRowBold3("60.000", 0, context),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      controller: ScrollController(),
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        border: TableBorder.all(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        columnSpacing: 30,
                                        headingRowHeight: 30,
                                        dataRowHeight: 30,
                                        columns: [
                                          datColBold("PO Supplier"),
                                          datColBold("mtr"),
                                          datColBold("kg"),
                                          datColBold("price/kg"),
                                          //datCol("Aksi"),
                                        ],
                                        rows: List.generate(
                                          20,
                                          (index) {
                                            return DataRow(
                                              cells: [
                                                datRowBold2("(W)760",
                                                    "05/09/2022", context),
                                                datRowBold1(
                                                    "24.000", 0, context),
                                                datRowBold1("326", 0, context),
                                                datRowBold1(
                                                    "59.000", 0, context),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      controller: ScrollController(),
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        border: TableBorder(
                                          bottom: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                          left: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                          right: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                          verticalInside: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                          horizontalInside: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        headingRowHeight: 30,
                                        dataRowHeight: 30,
                                        columnSpacing: 30,
                                        columns: [
                                          datColBoldSamping2("Total"),
                                          datColBoldSamping3("24.000"),
                                          datColBoldSamping3("326"),
                                          datColBoldSamping3("59.000"),
                                        ],
                                        rows: [
                                          DataRow(
                                            cells: [
                                              datRowBold1Samping(
                                                  "OUTSTANDING", 0, context),
                                              datRowBold4("8.820", 0, context),
                                              datRowBold4("125", 0, context),
                                              datRowBold4("1.000", 0, context),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // widget.controllerPageRecapDetail.animateToPage(0,
                        //         duration: const Duration(milliseconds: 250),
                        //         curve: Curves.ease);
                        widget.controllerPageRecap.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(
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
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 22),
                        backgroundColor: navButtonThird,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        _showInsertData(context);
                        //Navigator.pop(context);
                      },
                      child: const TextView(
                        val: "Insert Data",
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
