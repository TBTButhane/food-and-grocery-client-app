import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop4you/widgets/dimentions.dart';

class NoDataPage extends StatelessWidget {
  final String? imagelink;
  final String? imageText;
  const NoDataPage({Key? key, this.imagelink, this.imageText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.screenHeight * 0.55,
      width: Dimensions.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

             Padding(
              padding:EdgeInsets.only(left:Dimensions.width30, right:Dimensions.width30),
              child: Image(
                  height: Dimensions.height45 * 4,
                  width: Dimensions.height45 * 4,
                  fit: BoxFit.contain,
                  image: AssetImage(imagelink!)),
            ),

          SizedBox(
            height: Dimensions.height10,
          ),
          Center(
              child: Text(imageText!,
                  style: GoogleFonts.domine(
                      fontSize: Dimensions.font16 + 2,
                      fontWeight: FontWeight.w500)))
        ],
      ),
    );
  }
}
