import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';

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
        DetailRecapPage(controllerPageRecapDetail: _controllerPageRecapDetail)
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              datRow1("02-Jan-23", 1, context),
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
                              datRow1("001", 1, context),
                              datRow1("Reyner", 1, context),
                              datRow1("Ikan Salmon Laut 7g", 1, context),
                              datRow1("66.000", 1, context),
                              datRow1("15.180", 1, context),
                              datRow1("BBK", 1, context),
                              datRow1("BBK", 1, context),
                              datRow1("Completed", 1, context),
                              datRow1("100", 1, context),
                              datRow1("9000", 1, context),
                              datRow1("8500", 1, context),
                              datRow1("6300", 1, context),
                              datRow1("6450", 1, context),
                              datRow1("24000", 1, context),
                              datRow1("3100", 1, context),
                              datRow1("2364", 1, context),
                              datRow1("2164", 1, context),
                              datRow1("6640", 1, context),
                              datRow1("6200", 1, context),
                              datRow1("6000", 1, context),
                              datRow1("700", 1, context),
                              datRow1("500", 1, context),
                              datRow1("5000", 1, context),
                              datRow1("2000", 1, context),
                              datRow1("1000", 1, context),
                              datRow1("6000", 1, context),
                              datRow1("", 1, context),
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
                            datRow3(1, context)
                            //datRow3(2, context)
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
  const DetailRecapPage({required this.controllerPageRecapDetail, super.key});

  @override
  State<DetailRecapPage> createState() => _DetailRecapPageState();
}

class _DetailRecapPageState extends State<DetailRecapPage> {
  @override
  void initState() {
    super.initState();
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
                height: 800,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // controller: ScrollController(),
                  // physics: const ClampingScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
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
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.5),
                                          style: BorderStyle.solid,
                                          width: 1)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SingleChildScrollView(
                                        physics: const ClampingScrollPhysics(),
                                        controller: ScrollController(),
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          border: TableBorder.all(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                          headingRowHeight: 30,
                                          dataRowHeight: 30,
                                          columns: [
                                            datCol("NY"),
                                            datCol("mtr"),
                                            datCol("kg"),
                                            datCol("pice/kg"),
                                            //datCol("Aksi"),
                                          ],
                                          rows: List.generate(
                                            1,
                                            (index) {
                                              return DataRow(
                                                cells: [
                                                  datRow1(
                                                      "w (760)", 1, context),
                                                  datRow1("15.180", 1, context),
                                                  datRow1("201", 1, context),
                                                  datRow1("60.000", 1, context),
                                                  //datRow3(2, context)
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SingleChildScrollView(
                                        physics: const ClampingScrollPhysics(),
                                        controller: ScrollController(),
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          border: TableBorder.all(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            style: BorderStyle.solid,
                                          ),
                                          headingRowHeight: 30,
                                          dataRowHeight: 30,
                                          columns: [
                                            datCol("PO Supplier"),
                                            datCol("mtr"),
                                            datCol("kg"),
                                            datCol("pice/kg"),
                                            //datCol("Aksi"),
                                          ],
                                          rows: List.generate(
                                            1,
                                            (index) {
                                              return DataRow(
                                                cells: [
                                                  datRow1(
                                                      "w (760)", 1, context),
                                                  datRow1("15.180", 1, context),
                                                  datRow1("201", 1, context),
                                                  datRow1("60.000", 1, context),
                                                  //datRow3(2, context)
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
