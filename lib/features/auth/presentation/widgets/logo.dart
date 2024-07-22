import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';

Widget logoApp() {
  return SvgPicture.asset(
    IMGManger.logo,
    width: 80,
    height: 80,
  );
}
