import 'package:flutter/material.dart';
import 'package:iqchallenges/core/components/app_components.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rive/rive.dart';

Widget loginWid(
    {required AuthCubit cubit,
    required AuthState state,
    required BuildContext context}) {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  return Stack(
    children: [
      Form(
        key: formstate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Components.defText(text: "* اسمك"),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cubit.namecon,
              validator: (value) {
                if (value!.isEmpty) {
                  return "الاسم";
                }
              },
              style: TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                errorText: cubit.errorform == 1 ? "اسمك" : null,
                hintText: "ابراهيم..",
                hintStyle: TextStyle(color: AppColors.white),
                fillColor: Colors.transparent,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: AppColors.purple140, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: AppColors.purple140, width: 2),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Components.defText(text: "* اهتمامك"),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              dropdownColor: AppColors.purple,
              value: cubit.interested,
              elevation: 0,
              decoration: InputDecoration(
                errorText: cubit.errorform == 2 ? "عليك اختيار مجال" : null,
                labelText: 'مهتم بي',
                labelStyle: TextStyle(color: AppColors.white),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.purple140, width: 2)),
              ),
              items: cubit.interests.map((String company) {
                return DropdownMenuItem<String>(
                  value: company,
                  child: Components.defText(text: company, size: 16),
                );
              }).toList(),
              onChanged: (String? newValue) {
                cubit.interested = newValue!;
              },
            ),
            SizedBox(
              height: 70,
            ),
            Components.defButton(
                text: "بدء",
                onTap: () {
                  cubit.singIn(context);
                })
          ],
        ),
      ),
      state is SignInLoading
          ? CustomPositioned(
              child: RiveAnimation.asset(
                IMGManger.check,
                fit: BoxFit.cover,
                onInit: cubit.onCheckRiveInit,
              ),
            )
          : const SizedBox(),
      state is SignInLoading
          ? CustomPositioned(
              scale: 6,
              child: RiveAnimation.asset(
                IMGManger.confetti,
                onInit: cubit.onConfettiRiveInit,
                fit: BoxFit.cover,
              ),
            )
          : const SizedBox(),
    ],
  );
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
