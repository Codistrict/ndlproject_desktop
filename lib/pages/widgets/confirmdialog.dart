// ignore_for_file: todo
import 'package:flutter/material.dart';
import 'package:ndlproject_desktop/pages/widgets/textview.dart';
import 'package:ndlproject_desktop/themes/colors.dart';

class ConfirmDialog extends StatelessWidget {
  final String titleText;
  final String confirmText;
  final String declineText;
  final void Function()? confirmFunc;
  final void Function()? declineFunc;
  const ConfirmDialog(
      {super.key,
      required this.titleText,
      this.confirmText = "Ya",
      this.declineText = "No",
      this.confirmFunc,
      this.declineFunc});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(
                    Icons.warning,
                    size: 100,
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: TextView(
                    val: titleText.toString(),
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
                      onPressed: confirmFunc,
                      child: TextView(
                        val: confirmText.toString(),
                        color: lightText,
                        size: 15,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: declineFunc,
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
                      child: TextView(
                        val: declineText.toString(),
                        color: colorThird,
                        size: 15,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
