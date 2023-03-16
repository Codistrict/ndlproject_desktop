import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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

  @override
  void initState() {
    super.initState();
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
                  foregroundColor: Color(0xff13293D), // button text color
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
                                              child:
                                                  Icon(Icons.calendar_month)),
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
                              2,
                              (index) {
                                return DataRow(
                                  cells: [
                                    datRow1("02-Jan-23", 2, context),
                                    datRow1("17-Jan-23", 2, context),
                                    datRow1("16-Jan-23", 2, context),
                                    datRow1("14", 2, context),
                                    datRow1("V.161", 2, context),
                                    datRow1("Repeat", 2, context),
                                    datRow1("Tidak Ada", 2, context),
                                    datRow1("S", 2, context),
                                    datRow1("0001", 2, context),
                                    datRow1("Reyner", 2, context),
                                    datRow1("Ikan Laut sALMON 70g", 2, context),
                                    datRow1("3SS + Sealed", 2, context),
                                    datRow1("1", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("0", 2, context),
                                    datRow2("66.000", "60.000", context),
                                    datRow1("15.180", 2, context),
                                    datRow1("0.370", 2, context),
                                    datRow1("0.280", 2, context),
                                    datRow1("0.070", 2, context),
                                    datRow1("0.740", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("8", 2, context),
                                    datRow4("PET", "15", "u", "1.16", context),
                                    datRow1("0.760", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("-0.760", 2, context),
                                    datRow4("PE1", "80", "u", "0.92", context),
                                    datRow1("0.760", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("-0.760", 2, context),
                                    datRow4("", "", "u", "", context),
                                    datRow1("0.760", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("-0.760", 2, context),
                                    datRow4("", "", "u", "", context),
                                    datRow1("0.760", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("-0.760", 2, context),
                                    datRow4("", "", "u", "", context),
                                    datRow1("0.760", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("-0.760", 2, context),
                                    datRow4("", "", "u", "", context),
                                    datRow1("0.760", 2, context),
                                    datRow1("", 2, context),
                                    datRow1("-0.760", 2, context),
                                    datRow1("200.074", 2, context),
                                    datRow1("46.16", 2, context),
                                    datRow1("46.16", 2, context),
                                    datRow1("849.11", 2, context),
                                    datRow1("-", 2, context),
                                    datRow1("-", 2, context),
                                    datRow1("-", 2, context),
                                    datRow1("849.11", 2, context),
                                    datRow1("-", 2, context),
                                    datRow1("849.11", 2, context),
                                    datRow1("-", 2, context),
                                    datRow1("-", 2, context),
                                    datRow1("-", 2, context),
                                    //datRow3(2, context)
                                  ],
                                );
                              },
                            ),
                          ),
                        )),
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
                            2,
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
                                            widget.controllerPageNdl
                                                .animateToPage(1,
                                                    duration: const Duration(
                                                        milliseconds: 250),
                                                    curve: Curves.ease);
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
                                        SizedBox(width: 5),
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
                                                                    25,
                                                                    0,
                                                                    25),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .warning,
                                                                    size: 100,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 25),
                                                                const Center(
                                                                  child:
                                                                      TextView(
                                                                    val:
                                                                        "Apakah Anda Yakin Ingin Mendelete Row Ini?",
                                                                    color:
                                                                        darkText,
                                                                    size: 18,
                                                                    weight:
                                                                        FontWeight
                                                                            .w700,
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
                                                                            horizontal:
                                                                                55,
                                                                            vertical:
                                                                                22),
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
                                                                            "Ya, Delete Row Ini",
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
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          side: const BorderSide(
                                                                              width: 2, // the thickness
                                                                              color: ColorThird // the color of the border
                                                                              )),
                                                                      child:
                                                                          const TextView(
                                                                        val:
                                                                            "Ya, Delete Row Ini",
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height: 40,
                                            child: const Center(
                                                child: Icon(
                                              Icons.delete,
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
                  Container(
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class EditNdlPage extends StatefulWidget {
  final PageController controllerPageNdlEdit;
  const EditNdlPage({required this.controllerPageNdlEdit, super.key});

  @override
  State<EditNdlPage> createState() => _EditNdlPageState();
}

class _EditNdlPageState extends State<EditNdlPage> {
  final _controllerNamaBarangTambahPenjualan = TextEditingController();
  final List<String> _namaStockArray = [
    "Tambahkan Data Tgl",
    "Customer Delivery Date",
    "Job Done",
    "Durasi"
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
                SizedBox(height: 35),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    physics: const ClampingScrollPhysics(),
                    itemCount: indexTambah,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextView(
                                      val: "Pilih Kolom Yang Ingin Di Edit",
                                      color: darkText,
                                      size: 15,
                                      weight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: deviceWidth / 2,
                                      child: TypeAheadField<String>(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          controller:
                                              _controllerNamaBarangTambahPenjualan,
                                          autofocus: false,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: lightText,
                                            hintText: 'Pilih Nama Barang',
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                color: darkText,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                color: darkText,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                        onSuggestionSelected:
                                            (String suggestion) {
                                          _controllerNamaBarangTambahPenjualan
                                              .text = suggestion;
                                          print(suggestion);
                                        },
                                        getImmediateSuggestions: true,
                                        hideSuggestionsOnKeyboardHide: false,
                                        hideOnEmpty: false,
                                        noItemsFoundBuilder: (context) =>
                                            const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text("Tidak ada model"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextView(
                                      val: "Model",
                                      color: darkText,
                                      size: 15,
                                      weight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: deviceWidth / 2,
                                      child: TextField(
                                        readOnly: false,
                                        // controller:
                                        //     _controllerJumlahBarangTambahPenjualan,
                                        showCursor: false,
                                        keyboardType: TextInputType.number,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                        onChanged: (value) {},
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: lightText,
                                          hintStyle: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: darkText,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: darkText,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: darkText,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff13293D),
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      setState(() {
                                        indexTambah = indexTambah + 1;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: lightText,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff13293D),
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      if (indexTambah > 1) {
                                        setState(() {
                                          indexTambah = indexTambah - 1;
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: lightText,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 155),
                  child: Row(
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
                          Navigator.pop(context);
                        },
                        child: const TextView(
                          val: "Simpan",
                          color: lightText,
                          size: 15,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
