// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/widgets/app_icon_text.dart';

class AccountWidget extends StatelessWidget {
  AppIconAndText appIconAndText;
  AccountWidget({
    Key? key,
    required this.appIconAndText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width15,
          right: Dimensions.width15,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      child: SizedBox(child: appIconAndText),
    );
  }
}
