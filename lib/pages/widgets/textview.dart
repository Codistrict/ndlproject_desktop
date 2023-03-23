import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:intl/intl.dart';

class TextView extends StatelessWidget {
  final String val;
  final double size;
  final Color color;
  final FontWeight weight;
  const TextView({
    super.key,
    required this.val,
    this.size = 14,
    this.color = lightText,
    this.weight = FontWeight.w200,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      val,
      style: GoogleFonts.inter(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}

DateTime _selectedDate = DateTime.now();
String _formattedDate = "";
String _date = "Date";

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
  if (picked != null && picked != _selectedDate) {
    _selectedDate = picked;
    _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
    _date = _formattedDate;
  }
}

_showEdit(context) {
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
                            val: "Edit Data",
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
                              width: MediaQuery.of(context).size.width * 0.5,
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
                                          child:
                                              const Icon(Icons.calendar_month)),
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
  );
}

peringatanDialog(context) {
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
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.warning,
                          size: 100,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Center(
                        child: TextView(
                          val: "Apakah Anda Yakin Ingin Update Data Ini?",
                          color: darkText,
                          size: 18,
                          weight: FontWeight.w700,
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
                              _showEdit(context);
                            },
                            child: const TextView(
                              val: "Ya",
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
                                  color: colorThird // the color of the border
                                  ),
                            ),
                            child: const TextView(
                              val: "Tidak",
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
              ),
            ),
          );
        },
      );
    },
  );
}

datCol(value) {
  return DataColumn(
    label: Column(
      children: [
        Expanded(
          child: Center(
            child: TextView(
              val: value.toString(),
              color: darkText,
              size: 14,
              weight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

datColBold(value) {
  return DataColumn(
    label: SizedBox(
      width: 180,
      child: Center(
        child: TextView(
          val: value.toString(),
          color: darkText,
          size: 14,
          weight: FontWeight.w700,
        ),
      ),
    ),
  );
}

datColBold2(value) {
  return DataColumn(
    label: SizedBox(
      width: 100,
      child: Center(
        child: TextView(
          val: value.toString(),
          color: darkText,
          size: 13,
          weight: FontWeight.w700,
        ),
      ),
    ),
  );
}

datColBoldSamping(value) {
  return DataColumn(
    label: SizedBox(
      width: 180,
      child: Center(
        child: TextView(
          val: value.toString(),
          color: darkText,
          size: 13,
          weight: FontWeight.w500,
        ),
      ),
    ),
  );
}

datColBoldSamping3(value) {
  return DataColumn(
    label: SizedBox(
      width: 180,
      child: Center(
        child: TextView(
          val: value.toString(),
          color: darkText,
          size: 13,
          weight: FontWeight.w700,
        ),
      ),
    ),
  );
}

datColBoldSamping2(value) {
  return DataColumn(
    label: SizedBox(
      width: 180,
      child: TextView(
        val: value.toString(),
        color: darkText,
        size: 13,
        weight: FontWeight.w700,
      ),
    ),
  );
}

datRowBold1(value1, pw, context) {
  return DataCell(
    GestureDetector(
      child: SizedBox(
        width: 180,
        child: Center(
          child: TextView(
            val: value1.toString(),
            size: 13,
            color: darkText,
            weight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

datRowBold4(value1, pw, context) {
  return DataCell(
    GestureDetector(
      child: SizedBox(
        width: 180,
        child: Center(
          child: TextView(
            val: value1.toString(),
            size: 13,
            color: darkText,
            weight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

datRowBold3(value1, pw, context) {
  return DataCell(
    GestureDetector(
      child: SizedBox(
        width: 100,
        child: Center(
          child: TextView(
            val: value1.toString(),
            size: 13,
            color: darkText,
            weight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

datRowBold1Samping(value1, pw, context) {
  return DataCell(
    GestureDetector(
      child: SizedBox(
        width: 180,
        child: TextView(
          val: value1.toString(),
          size: 13,
          color: darkText,
          weight: FontWeight.w700,
        ),
      ),
    ),
  );
}

datRowBold2(value1, value2, context) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 65,
          child: Center(
            child: TextView(
              val: value1.toString(),
              color: darkText,
              size: 13,
              weight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: 85,
          child: Center(
            child: TextView(
              val: value2.toString(),
              color: darkText,
              size: 13,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

datRow1(value1, pw, context) {
  return DataCell(
    GestureDetector(
      child: Center(
        child: TextView(
          val: value1.toString(),
          size: 13,
          color: darkText,
          weight: FontWeight.w500,
        ),
      ),
    ),
  );
}

datRowrRecap(value1) {
  return DataCell(
    Center(
      child: TextView(
        val: value1.toString(),
        size: 13,
        color: darkText,
        weight: FontWeight.w500,
      ),
    ),
  );
}

datRow2(value1, value2, context) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: TextView(
              val: value1.toString(),
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Center(
            child: TextView(
              val: value2.toString(),
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

datRow4(value1, value2, value3, value4, context) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: TextView(
              val: value1.toString(),
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Center(
            child: TextView(
              val: value2.toString(),
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Center(
            child: TextView(
              val: value3.toString(),
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Center(
            child: TextView(
              val: value4.toString(),
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

textFieldYa(color) {
  return TextField(
    readOnly: false,
    // controller:
    //     _controllerJumlahBarangTambahPenjualan,
    showCursor: false,
    style: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    onChanged: (value) {},
    decoration: InputDecoration(
      filled: true,
      fillColor: color,
      hintStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
  );
}
