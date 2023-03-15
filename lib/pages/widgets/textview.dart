import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndlproject_desktop/themes/colors.dart';

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
                                SizedBox(height: 13),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: darkText,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(9),
                                          child: Icon(Icons.calendar_month),
                                        ),
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
            onTap: () {},
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
