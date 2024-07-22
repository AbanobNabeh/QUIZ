import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/config/routes/approutes.dart';
import 'package:iqchallenges/config/shared%20preferences/shared_preferences.dart';
import 'package:iqchallenges/core/utils/app_sring.dart';
import 'package:iqchallenges/features/auth/presentation/pages/login.dart';
import 'package:iqchallenges/features/quiz/presentation/pages/homepage.dart';
import 'package:rive/rive.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(HomeInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  TextEditingController namecon = TextEditingController();
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;
  late SMITrigger confetti;
  int errorform = 0;
  String? interested;
  List<String> interests = ['برمجه', 'كرة قدم', 'رياضيات', 'علوم'];
  void initsplash(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (Stringconstants.name.isEmpty) {
        AppRoutes.animrouteremove(context: context, screen: LoginScreen());
      } else {
        AppRoutes.animrouteremove(context: context, screen: HomePage());
      }
    });
  }

  void onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singIn(
    BuildContext context,
  ) {
    emit(SignInLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (namecon.text != '' && interested != null) {
          success.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              confetti.fire();
              Future.delayed(const Duration(seconds: 1), () {
                CacheHelper.saveData(
                        key: Stringconstants.username, value: namecon.text)
                    .then((value) {
                  CacheHelper.saveData(
                      key: Stringconstants.interested, value: interested);
                  CacheHelper.saveData(
                      key: Stringconstants.currentlvl, value: 1);
                  Stringconstants.name = namecon.text;
                  Stringconstants.interestedin = interested!;

                  AppRoutes.animrouteremove(
                      context: context, screen: const HomePage());
                });
                emit(SignInSuccess());
              });
            },
          );
        } else {
          namecon.text == '' ? errorform = 1 : errorform = 2;
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              reset.fire();
              emit(SignInSuccess());
            },
          );
        }
      },
    );
  }
}
