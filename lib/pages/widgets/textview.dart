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

datCol(value) {
  return DataColumn(
    label: Expanded(
      child: Center(
        child: TextView(
          val: value,
          color: darkText,
          weight: FontWeight.w500,
        ),
      ),
    ),
  );
}

datRow1(value1) {
  return DataCell(
    Expanded(
      child: Center(
        child: TextView(
          val: value1,
          color: darkText,
        ),
      ),
    ),
  );
}

datRow2(value1, value2) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: TextView(
              val: value1,
              color: darkText,
            ),
          ),
        ),
        const VerticalDivider(
          width: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Colors.grey,
        ),
        Expanded(
          child: Center(
            child: TextView(
              val: value2,
              color: darkText,
            ),
          ),
        ),
      ],
    ),
  );
}

datRow3() {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: Container(
              height: 80,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                        width: 1, // the thickness
                        color: Colors.black // the color of the border
                        ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
                  child: Icon(Icons.edit, size: 20,)),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              height: 80,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                        width: 1, // the thickness
                        color: Colors.black // the color of the border
                        ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
                  child: Icon(Icons.edit, size: 20,)),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              height: 80,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                        width: 1, // the thickness
                        color: Colors.black // the color of the border
                        ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
                  child: Icon(Icons.edit, size: 20,)),
            ),
          ),
        ),
      ],
    ),
  );
}

datRow4(value1, value2, value3, value4) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: TextView(
              val: value1,
              color: darkText,
            ),
          ),
        ),
        const VerticalDivider(
          width: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Colors.grey,
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextView(
              val: value2,
              color: darkText,
            ),
          ),
        ),
        const VerticalDivider(
          width: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Colors.grey,
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextView(
              val: value3,
              color: darkText,
            ),
          ),
        ),
        const VerticalDivider(
          width: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Colors.grey,
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextView(
              val: value4,
              color: darkText,
            ),
          ),
        ),
      ],
    ),
  );
}
