// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodExpandedText extends StatefulWidget {
  final String text;
  const FoodExpandedText({Key? key, required this.text}) : super(key: key);

  @override
  FoodExpandedTextState createState() => FoodExpandedTextState();
}

class FoodExpandedTextState extends State<FoodExpandedText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 200.0;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(widget.text,
                style: GoogleFonts.roboto(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontSize: 16))
            : Column(
                children: [
                  Text(
                      hiddenText
                          ? ("$firstHalf ...")
                          : (firstHalf + secondHalf),
                      style: GoogleFonts.roboto(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          fontSize: 16)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        Text(hiddenText ? "Show more" : "Show less",
                            style: GoogleFonts.roboto(
                                color: Colors.blue.shade400,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                            hiddenText
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: Colors.blue.shade400)
                      ],
                    ),
                  )
                ],
              ));
  }
}
