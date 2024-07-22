import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';

class Components {
  static Widget defText(
      {required String text,
      Color? color,
      double size = 20,
      TextAlign textAlign = TextAlign.start,
      FontWeight fontWeight = FontWeight.normal,
      int lines = 3,
      double letterSpacing = 0}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color == null ? Colors.white : color,
          fontSize: size,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }

  static Widget defButton(
      {textColor = Colors.white,
      double width = double.infinity,
      double height = 55,
      double border = 8,
      FontWeight fontWeight = FontWeight.normal,
      double sizetxt = 18,
      bool enable = true,
      required text,
      required Function()? onTap,
      bool isloading = false}) {
    return enable
        ? InkWell(
            onTap: isloading ? null : onTap,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(border),
              ),
              child: Center(
                child: isloading
                    ? CircularProgressIndicator(
                        color: textColor,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          text,
                          style: TextStyle(
                              color: textColor,
                              fontWeight: fontWeight,
                              fontSize: sizetxt),
                        ),
                      ),
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.purple220,
              borderRadius: BorderRadius.circular(border),
            ),
            child: Center(
              child: isloading
                  ? CircularProgressIndicator(
                      color: textColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: AppColors.primary.withOpacity(0.5),
                            fontWeight: fontWeight,
                            fontSize: sizetxt),
                      ),
                    ),
            ),
          );
  }
}
