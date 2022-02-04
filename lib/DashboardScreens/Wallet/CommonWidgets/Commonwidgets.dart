import 'package:flutter/material.dart';

commonTextStyles() {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xff09098A),
  );
}

commonWhiteButtonTextStyles() {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xff09098A),
  );
}

commonBlueButtonTextStyles() {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xffffffff),
  );
}

commonContinueButtonStyle() {
  return TextButton.styleFrom(
      backgroundColor: Color(0xff09098A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      minimumSize: Size(300, 60));
}

commonSmallButtonStyle() {
  return TextButton.styleFrom(
      elevation: 5.0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      minimumSize: Size(120, 40));
}

commonBlueButtons() {
  return TextButton.styleFrom(
      elevation: 5.0,
      backgroundColor: Color(0xff09098A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      minimumSize: Size(120, 50));
}

commonCardStyle() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(22.0),
  );
}
