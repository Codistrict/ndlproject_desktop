import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:number_paginator/number_paginator.dart';

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
  int numberOfPage = 100;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  _showEdit(dw, dh) {
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
                                SizedBox(height: 13),
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
                                      padding: EdgeInsets.all(9),
                                      child: Row(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                const TextView(
                                  val: "Update Delivery Period",
                                  color: darkText,
                                  size: 16,
                                  weight: FontWeight.w600,
                                ),
                                SizedBox(height: 13),
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
                                      padding: EdgeInsets.all(9),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 55, vertical: 22),
                                        primary: Colors.white,
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
                                                  ColorThird // the color of the border
                                              )),
                                      child: const TextView(
                                        val: "Batal",
                                        color: ColorThird,
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
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
              child: Row(
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
                          datCol("Film 1 (M)"),
                          datCol("Film 2 (M)"),
                          datCol("Film 2 (M)"),
                          datCol("Film 3 (M)"),
                          datCol("Film 3 (M)"),
                          datCol("Film 4 (M)"),
                          datCol("Film 4 (M)"),
                          datCol("Film 5 (M)"),
                          datCol("Film 5 (M)"),
                          datCol("Film 6 (M)"),
                          datCol("Film 6 (M)"),
                          datCol("Price 1 Diff"),
                          datCol("Price 2 Diff"),
                          datCol("Price 3 Diff"),
                          datCol("Price 4 Diff"),
                          datCol("Price 5 Diff"),
                          datCol("Price 6 Diff"),
                          datCol("Comment/Note"),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              datRowrRecap("02-Jan-23"),
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
                              datRowrRecap("001"),
                              datRowrRecap("Reyner"),
                              datRowrRecap("Ikan Salmon Laut 7g"),
                              datRowrRecap("66.000"),
                              datRowrRecap("15.180"),
                              datRowrRecap("BBK"),
                              datRowrRecap("BBK"),
                              datRowrRecap("Completed"),
                              datRowrRecap("100"),
                              datRowrRecap("9000"),
                              datRowrRecap("8500"),
                              datRowrRecap("6300"),
                              datRowrRecap("6450"),
                              datRowrRecap("24000"),
                              datRowrRecap("3100"),
                              datRowrRecap("2364"),
                              datRowrRecap("2164"),
                              datRowrRecap("6640"),
                              datRowrRecap("6200"),
                              datRowrRecap("6000"),
                              datRowrRecap("700"),
                              datRowrRecap("500"),
                              datRowrRecap("5000"),
                              datRowrRecap("2000"),
                              datRowrRecap("1000"),
                              datRowrRecap("6000"),
                              datRowrRecap(""),
                            ],
                            onLongPress: () {
                              widget.controllerPageRecap.animateToPage(1,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.ease);
                            },
                          ),
                        ]),
                  )),
                  DataTable(
                    border: TableBorder(
                        top: BorderSide(color: Colors.black.withOpacity(0.5)),
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.5)),
                        horizontalInside: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                            style: BorderStyle.solid)),
                    headingRowHeight: 50,
                    dataRowHeight: 50,
                    columns: [
                      datCol("Aksi"),
                    ],
                    rows: List.generate(
                      1,
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
                                            builder: (context, setState) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ScrollConfiguration(
                                                  behavior:
                                                      ScrollConfiguration.of(
                                                              context)
                                                          .copyWith(
                                                    dragDevices: {
                                                      PointerDeviceKind.touch,
                                                      PointerDeviceKind.mouse,
                                                    },
                                                  ),
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    controller:
                                                        ScrollController(),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 15, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Center(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child: TextView(
                                                                val:
                                                                    "Update Rekap",
                                                                color: darkText,
                                                                size: 25,
                                                                weight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            thickness: 1,
                                                            height: 20,
                                                            color: darkText,
                                                          ),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20,
                                                                      20,
                                                                      20,
                                                                      15),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const TextView(
                                                                    val:
                                                                        "Update Status",
                                                                    color:
                                                                        darkText,
                                                                    size: 16,
                                                                    weight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          13),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.5,
                                                                    child: DropdownSearch<
                                                                        String>(
                                                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                                                          textAlign: TextAlign.left,
                                                                          dropdownSearchDecoration: InputDecoration(
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                Colors.transparent,
                                                                            iconColor:
                                                                                darkText,
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: darkText,
                                                                              ),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: darkText,
                                                                              ),
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: darkText,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      popupProps:
                                                                          const PopupProps
                                                                              .menu(
                                                                        fit: FlexFit
                                                                            .loose,
                                                                        showSelectedItems:
                                                                            false,
                                                                        menuProps:
                                                                            MenuProps(backgroundColor: Color(0xffeee8f4)),
                                                                      ),
                                                                      items: const [
                                                                        "Completed 1",
                                                                        "Completed 2",
                                                                        "Completed 3",
                                                                      ],
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      selectedItem:
                                                                          "",
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          25),
                                                                  const TextView(
                                                                    val:
                                                                        "Update Delivery Period",
                                                                    color:
                                                                        darkText,
                                                                    size: 16,
                                                                    weight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          13),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.5,
                                                                    child: DropdownSearch<
                                                                        String>(
                                                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                                                          textAlign: TextAlign.left,
                                                                          dropdownSearchDecoration: InputDecoration(
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                Colors.transparent,
                                                                            iconColor:
                                                                                darkText,
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: darkText,
                                                                              ),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: darkText,
                                                                              ),
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: darkText,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      popupProps:
                                                                          const PopupProps
                                                                              .menu(
                                                                        fit: FlexFit
                                                                            .loose,
                                                                        showSelectedItems:
                                                                            false,
                                                                        menuProps:
                                                                            MenuProps(backgroundColor: Color(0xffeee8f4)),
                                                                      ),
                                                                      items: const [
                                                                        "Completed 1",
                                                                        "Completed 2",
                                                                        "Completed 3",
                                                                      ],
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      selectedItem:
                                                                          "",
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 40,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      ElevatedButton(
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 55,
                                                                              vertical: 22),
                                                                          primary:
                                                                              Colors.white,
                                                                          backgroundColor:
                                                                              navButtonThird,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const TextView(
                                                                          val:
                                                                              "Submit",
                                                                          color:
                                                                              lightText,
                                                                          size:
                                                                              15,
                                                                          weight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 22),
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            side: const BorderSide(
                                                                                width: 2, // the thickness
                                                                                color: ColorThird // the color of the border
                                                                                )),
                                                                        child:
                                                                            const TextView(
                                                                          val:
                                                                              "Batal",
                                                                          color:
                                                                              ColorThird,
                                                                          size:
                                                                              15,
                                                                          weight:
                                                                              FontWeight.w600,
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
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: darkText,
                                            width: 0.4,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(5),
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
              ),
            ),
            Center(
              child: Container(
                width: deviceWidth / 2,
                child: Padding(
                  padding: EdgeInsets.all(30),
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

  Future<void> selectFilterDateInsert(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateInsert,
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
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
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
                                            val: "Nama PO Supplier",
                                            size: 15,
                                            color: darkText,
                                            weight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 5),
                                          TextFieldYa(),
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
                                          SizedBox(height: 5),
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
                                              padding: EdgeInsets.all(9),
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
                                SizedBox(height: 10,),
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
                                          SizedBox(height: 5),
                                          TextFieldYa(),
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
                                          SizedBox(height: 5),
                                          TextFieldYa(),
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
                                          SizedBox(height: 5),
                                          TextFieldYa(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 55, vertical: 22),
                                        primary: Colors.white,
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
                                                  ColorThird // the color of the border
                                              )),
                                      child: const TextView(
                                        val: "Batal",
                                        color: ColorThird,
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
    final deviceWidth = MediaQuery.of(context).size.width;
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
                      SizedBox(width: 55),
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
                      SizedBox(width: 55),
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
              SizedBox(
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
                                  SizedBox(height: 15),
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
                                  SizedBox(
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
                                              datRowBold1("24.000", 0, context),
                                              datRowBold1("326", 0, context),
                                              datRowBold1("59.000", 0, context),
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
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        left: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        right: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        verticalInside: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                        ),
                                        horizontalInside: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
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
              SizedBox(height: 15),
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
                            color: ColorThird // the color of the border
                            )),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_outlined, color: ColorThird),
                        SizedBox(width: 5),
                        TextView(
                          val: "Back",
                          color: ColorThird,
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
    ));
  }
}
