import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndlproject_desktop/themes/colors.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  if (picked != null && picked != _selectedDate) {
    _selectedDate = picked;
    _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
    _date = _formattedDate;
  }
}

TextFieldYa() {
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
      fillColor: const Color(0xffeee8f4),
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

datCol(value) {
  return DataColumn(
    label: Column(
      children: [
        Expanded(
          child: Center(
            child: TextView(
              val: value,
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
          val: value,
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
          val: value,
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
          val: value,
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
          val: value,
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
        val: value,
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
            val: value1,
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
            val: value1,
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
            val: value1,
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
          val: value1,
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
              val: value1,
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
              val: value2,
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
          val: value1,
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
        val: value1,
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
              val: value1,
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
              val: value2,
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
              val: value1,
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
              val: value2,
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
              val: value3,
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
              val: value4,
              color: darkText,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
