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
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
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
                                            child: Icon(Icons.calendar_month)),
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
                      SizedBox(height: 25),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 22),
                              primary: Colors.white,
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
                                    color: ColorThird // the color of the border
                                    )),
                            child: const TextView(
                              val: "Tidak",
                              color: ColorThird,
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
              val: value,
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

datColBold(value) {
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

datColBoldSamping2(value) {
  return DataColumn(
    label: SizedBox(
      width: 180,
      child: TextView(
        val: value,
        color: darkText,
        size: 13,
        weight: FontWeight.w500,
      ),
    ),
  );
}

datRowBold1(value1, pw, context) {
  return DataCell(
    GestureDetector(
      onLongPress: () {
        if (pw == 1) {
          peringatanDialog(context);
        } else {
          print("Tidak Dapat Ditekan");
        }
      },
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

datRowBold3(value1, pw, context) {
  return DataCell(
    GestureDetector(
      onLongPress: () {
        if (pw == 1) {
          peringatanDialog(context);
        } else {
          print("Tidak Dapat Ditekan");
        }
      },
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
      onLongPress: () {
        if (pw == 1) {
          peringatanDialog(context);
        } else {
          print("Tidak Dapat Ditekan");
        }
      },
      child: SizedBox(
        width: 180,
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
      onLongPress: () {
        if (pw == 1) {
          peringatanDialog(context);
        } else {
          print("Tidak Dapat Ditekan");
        }
      },
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
          child: GestureDetector(
            onLongPress: () {
              peringatanDialog(context);
            },
            child: Center(
              child: TextView(
                val: value1,
                color: darkText,
                weight: FontWeight.w500,
              ),
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

datRow3(pilih, context) {
  if (pilih == 1) {
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextView(
                                            val: "Update Status",
                                            color: darkText,
                                            size: 16,
                                            weight: FontWeight.w600,
                                          ),
                                          SizedBox(height: 13),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: DropdownSearch<String>(
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                      textAlign: TextAlign.left,
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        iconColor: darkText,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                            color: darkText,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                            color: darkText,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                            color: darkText,
                                                          ),
                                                        ),
                                                      )),
                                              popupProps: const PopupProps.menu(
                                                fit: FlexFit.loose,
                                                showSelectedItems: false,
                                                menuProps: MenuProps(
                                                  backgroundColor: Color(0xffeee8f4)
                                                ),
                                              ),
                                              items: const [
                                                "Completed 1",
                                                "Completed 2",
                                                "Completed 3",
                                              ],
                                              onChanged: (val) {
                                                setState(() {
                                                });
                                              },
                                              selectedItem: "",
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: DropdownSearch<String>(
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                      textAlign: TextAlign.left,
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        iconColor: darkText,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                            color: darkText,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                            color: darkText,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                            color: darkText,
                                                          ),
                                                        ),
                                                      )),
                                              popupProps: const PopupProps.menu(
                                                fit: FlexFit.loose,
                                                showSelectedItems: false,
                                                menuProps: MenuProps(
                                                  backgroundColor: Color(0xffeee8f4)
                                                ),
                                              ),
                                              items: const [
                                                "Completed 1",
                                                "Completed 2",
                                                "Completed 3",
                                              ],
                                              onChanged: (val) {
                                                setState(() {
                                                });
                                              },
                                              selectedItem: "",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 55,
                                                      vertical: 22),
                                                  primary: Colors.white,
                                                  backgroundColor:
                                                      navButtonThird,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 55,
                                                        vertical: 22),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    side: const BorderSide(
                                                        width:
                                                            2, // the thickness
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
              );
            },
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    color: darkText, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
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
    );
  }
  if (pilih == 2) {
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  SizedBox(height: 25),
                                  const Center(
                                    child: TextView(
                                      val:
                                          "Apakah Anda Yakin Ingin Mendelete Row Ini?",
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
                                          val: "Ya, Delete Row Ini",
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
                                          val: "Ya, Delete Row Ini",
                                          color: ColorThird,
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
            },
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    color: darkText, width: 0.4, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(5),
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
    );
  }
}

datRow4(value1, value2, value3, value4, context) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              peringatanDialog(context);
            },
            child: Center(
              child: TextView(
                val: value1,
                color: darkText,
                weight: FontWeight.w500,
              ),
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
          child: GestureDetector(
            onLongPress: () {
              peringatanDialog(context);
            },
            child: Center(
              child: TextView(
                val: value2,
                color: darkText,
                weight: FontWeight.w500,
              ),
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
          child: GestureDetector(
            onLongPress: () {
              peringatanDialog(context);
            },
            child: Center(
              child: TextView(
                val: value3,
                color: darkText,
                weight: FontWeight.w500,
              ),
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
          child: GestureDetector(
            onLongPress: () {
              peringatanDialog(context);
            },
            child: Center(
              child: TextView(
                val: value4,
                color: darkText,
                weight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
