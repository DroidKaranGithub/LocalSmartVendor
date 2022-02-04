import 'package:flutter/material.dart';
import 'package:shop_project/Constants/Constant.dart';

class ColorButton extends StatelessWidget {
  final String? title;
  bool? RoundCorner;
  bool? IsIconAvailable;
  Widget? widget;
  double? width;
  Color? colorValue;
  TextStyle? style;
  double? height;
  bool? IsCenter = false;
  bool? IsTextStyle = false;
  ColorButton(
      {this.IsCenter,
      this.height,
      this.colorValue,
      this.title,
      this.RoundCorner,
      this.IsIconAvailable,
      this.widget,
      this.width,
      this.IsTextStyle,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: width,
      decoration: BoxDecoration(
        color: colorValue ?? orange,
        borderRadius: RoundCorner == true
            ? BorderRadius.circular(35)
            : BorderRadius.circular(5),
      ),
      child: IsIconAvailable == true
          ? widget
          : IsCenter == false
              ? Padding(
                  padding: const EdgeInsets.only(left: 26, top: 15),
                  child: Text(
                    title!,
                    style: IsTextStyle == true
                        ? style
                        : Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                  ),
                )
              : Center(
                  child: Text(
                    title!,
                    style: IsTextStyle == true
                        ? style
                        : Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                  ),
                ),
    );
  }
}
