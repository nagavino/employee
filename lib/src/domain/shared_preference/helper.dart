import 'package:flutter/material.dart';

import 'package:responsive_ui/responsive_ui.dart';

class Helper {
  static mediaSize(context, type, value) {
    var size = MediaQuery.of(context).size;
    if (type == 'height') {
      return value != 'no' ? size.height * value : size.height;
    } else {
      return value != 'no' ? size.width * value : size.width;
    }
  }

  static boxShadow(double blur, context) {
    return BoxShadow(
      blurRadius: 6,
      color: Theme.of(context).colorScheme.tertiaryContainer,
      spreadRadius: 1,
      /*offset: const Offset(0, 1),*/
    );
  }

  static divisionValue(colSize,
      {dynamic s, dynamic m, dynamic l, dynamic xl = 0, dynamic xs = 0}) {
    if (xl == 0 && xs == 0) {
      return Division(
        colS: int.tryParse(s.toString()) ?? colSize,
        colM: int.tryParse(m.toString()) ?? colSize,
        colL: int.tryParse(l.toString()) ?? colSize,
      );
    } else {
      return Division(
        colS: int.tryParse(s.toString()) ?? colSize,
        colXS: int.tryParse(xs.toString()) ?? colSize,
        colM: int.tryParse(m.toString()) ?? colSize,
        colL: int.tryParse(l.toString()) ?? colSize,
        colXL: int.tryParse(xl.toString()) ?? colSize,
      );
    }
  }

  static responsiveScreenSize(context,
      {required String type,
      typeValue,
      deviceSize,
      dynamic success,
      dynamic fail}) {
    return Helper.mediaSize(context, type, typeValue) > deviceSize
        ? success
        : fail;
  }
}
