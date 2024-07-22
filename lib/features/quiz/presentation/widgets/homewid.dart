import 'package:flutter/material.dart';
import 'package:iqchallenges/config/routes/approutes.dart';
import 'package:iqchallenges/core/components/app_components.dart';
import 'package:iqchallenges/core/utils/app_sring.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:iqchallenges/features/quiz/presentation/pages/quizscreen.dart';

Widget profileCard(QuizCubit cubit) {
  return Container(
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                SizedBox(height: 40),
                Components.defText(
                    text: Stringconstants.name, fontWeight: FontWeight.bold),
                SizedBox(height: 7),
                Components.defText(
                    text: Stringconstants.interestedin, size: 16),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Components.defText(text: "التقييم", size: 16),
                          Components.defText(
                              text: cubit.rating().toString(),
                              color: AppColors.purple140,
                              size: 16),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: AppColors.white,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Components.defText(text: "المستوي", size: 16),
                          Components.defText(
                              text: Stringconstants.currentlevel.toString(),
                              color: AppColors.purple140,
                              size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              IMGManger.user,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget lvlWid(
    {required int index, required Map lvl, required BuildContext context}) {
  return InkWell(
    onTap: lvl['status'] == 'open'
        ? () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Components.defButton(
                      text: 'بدء',
                      onTap: () => AppRoutes.animremoves(
                          context: context, screen: QuizScreen(lvl['level']))),
                );
              },
            );
          }
        : null,
    child: Container(
      decoration: BoxDecoration(
        color: lvl['status'] == 'won'
            ? Colors.green
            : lvl['status'] == 'lost'
                ? Colors.red
                : AppColors.purple140,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              lvl['status'] == 'won' || lvl['status'] == 'lost'
                  ? const SizedBox()
                  : Components.defText(text: 'مستوي'),
              Components.defText(text: '${index + 1}', size: 16),
              lvl['status'] == 'close' || lvl['status'] == 'open'
                  ? SizedBox()
                  : rate(lvl['rate']),
              lvl['status'] == 'close' || lvl['status'] == 'open'
                  ? const SizedBox()
                  : Components.defText(
                      text:
                          '00:${lvl['time'] >= 10 ? lvl['time'] : '0${lvl['time']}'}',
                      size: 14),
            ],
          ),
          lvl['status'] != 'close'
              ? const SizedBox()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.black.withOpacity(0.6),
                  child: Icon(
                    Icons.lock,
                    color: AppColors.white,
                  ),
                ),
        ],
      ),
    ),
  );
}

Widget rate(double rate) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.star,
        size: 20,
        color: rate >= 1 ? AppColors.primary : AppColors.white,
      ),
      Icon(
        Icons.star,
        size: 20,
        color: rate >= 2 ? AppColors.primary : AppColors.white,
      ),
      Icon(
        Icons.star,
        size: 20,
        color: rate >= 3 ? AppColors.primary : AppColors.white,
      ),
    ],
  );
}
