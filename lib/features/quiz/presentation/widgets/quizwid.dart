import 'package:flutter/material.dart';
import 'package:iqchallenges/core/components/app_components.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';
import 'package:iqchallenges/features/quiz/presentation/cubit/quiz_cubit.dart';

Widget answerWid(String text, QuizCubit cubit, int index) {
  return InkWell(
    onTap: () => cubit.selectitem('${index + 1}'),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            border: cubit.itemselect == "${index + 1}"
                ? Border.all(color: AppColors.orange, width: 2)
                : null,
            borderRadius: BorderRadius.circular(12),
            color: AppColors.purple220),
        child: Center(
          child: Components.defText(text: text, size: 16),
        ),
      ),
    ),
  );
}
