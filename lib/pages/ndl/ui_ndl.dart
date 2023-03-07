import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';

class NdlPage extends StatefulWidget {
  const NdlPage({super.key});

  @override
  State<NdlPage> createState() => _NdlPageState();
}

class _NdlPageState extends State<NdlPage> {
  final List<DataRow> _rowList = List.empty(growable: true);

  @override
  void initState() {
    _rowList.clear();

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
              padding: const EdgeInsets.all(25),
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
                        dataRowHeight: 56,
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
                          datCol("Aksi"),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              datRow1("02-Jan-23"),
                              datRow1("17-Jan-23"),
                              datRow1("16-Jan-23"),
                              datRow1("14"),
                              datRow1("V.161"),
                              datRow1("Repeat"),
                              datRow1("Tidak Ada"),
                              datRow1("S"),
                              datRow1("0001"),
                              datRow1("Reyner"),
                              datRow1("Ikan Laut sALMON 70g"),
                              datRow1("3SS + Sealed"),
                              datRow1("1"),
                              datRow1(""),
                              datRow1("0"),

                              datRow2("66.000", "60.000"),

                              datRow1("15.180"),
                              datRow1("0.370"),
                              datRow1("0.280"),
                              datRow1("0.070"),
                              datRow1("0.740"),
                              datRow1(""),
                              datRow1(""),
                              datRow1("8"),

                              datRow4("PET", "15", "u", "1.16"),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("PE1", "80", "u", "0.92"),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow1("200.074"),
                              datRow1("46.16"),
                              datRow1("46.16"),
                              datRow1("849.11"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow1("849.11"),
                              datRow1("-"),
                              datRow1("849.11"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow3()
                            ],
                          ),
                          DataRow(
                            cells: [
                              datRow1("02-Jan-23"),
                              datRow1("17-Jan-23"),
                              datRow1("16-Jan-23"),
                              datRow1("14"),
                              datRow1("V.161"),
                              datRow1("Repeat"),
                              datRow1("Tidak Ada"),
                              datRow1("S"),
                              datRow1("0001"),
                              datRow1("Reyner"),
                              datRow1("Ikan Laut sALMON 70g"),
                              datRow1("3SS + Sealed"),
                              datRow1("1"),
                              datRow1(""),
                              datRow1("0"),

                              datRow2("66.000", "60.000"),

                              datRow1("15.180"),
                              datRow1("0.370"),
                              datRow1("0.280"),
                              datRow1("0.070"),
                              datRow1("0.740"),
                              datRow1(""),
                              datRow1(""),
                              datRow1("8"),

                              datRow4("PET", "15", "u", "1.16"),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("PE1", "80", "u", "0.92"),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow4("", "", "u", ""),
                              datRow1("0.760"),
                              datRow1(""),
                              datRow1("-0.760"),

                              datRow1("200.074"),
                              datRow1("46.16"),
                              datRow1("46.16"),
                              datRow1("849.11"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow1("849.11"),
                              datRow1("-"),
                              datRow1("849.11"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow1("-"),
                              datRow3()
                            ],
                          ),
                        ]),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
