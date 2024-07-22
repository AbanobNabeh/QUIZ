import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/config/network/dioapp.dart';
import 'package:iqchallenges/config/routes/approutes.dart';
import 'package:iqchallenges/config/shared%20preferences/shared_preferences.dart';
import 'package:iqchallenges/core/utils/app_sring.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/quiz/presentation/pages/quizscreen.dart';
import 'package:rive/rive.dart';
import 'package:sqflite/sqflite.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  static QuizCubit get(context) => BlocProvider.of(context);
  List lvls = [];
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer effectsound = AudioPlayer();

  void playsound(bool create) async {
    create ? createDB(navigator: false) : null;
    if (Stringconstants.backgroundSound) {
      audioPlayer.play(AssetSource(IMGManger.backgroundsound));
      audioPlayer.onPlayerComplete.listen((event) {
        playsound(false);
      });
    }
  }

  Database? database;
  void createDB({bool navigator = true}) async {
    navigator ? null : emit(GetLevelLoading());
    database = await openDatabase(
      'quiz.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''
        CREATE TABLE level (
          id INTEGER PRIMARY KEY,
          level INTEGER,
          time INTEGER,
          rate DOUBLE,
          status TEXT
        )
      ''');
        insertDB(db);
      },
      onOpen: (db) {
        Future.delayed(Duration(seconds: 1)).then((value) {
          getlvl(db);
        });
      },
    );
  }

  Future<void> insertDB(Database db) async {
    for (int i = 0; i <= 20; i++) {
      await db.transaction((txn) async {
        int insertedId = await txn.rawInsert(
            '''INSERT INTO level(level, time, rate, status) VALUES($i, 0, 0, '${i == 1 ? 'open' : 'close'}')''');
      });
    }
  }

  void getlvl(Database db) async {
    lvls = await db.rawQuery('Select * from level');
    emit(GetLevelSuccess());
  }

  String asked = '';
  List answer = [];
  String correct = '';
  String itemselect = '';
  void ask(BuildContext context, int currentlvl) async {
    timer != null ? timer!.cancel() : null;
    itemselect = '';
    asked = '';
    answer = [];
    correct = '';
    emit(GetAskLoading());
    var data = await DioApp.postData(level: currentlvl);
    asked = data!['ask'];
    answer = data['answer'];
    correct = data['correct'].toString();
    emit(GetAskSuccess());
    start = 60;
    startTimer(context, currentlvl);
    getlvl(database!);
  }

  void selectitem(String value) {
    itemselect = value;
    emit(SelectItemState());
  }

  int start = 60;
  Timer? timer;
  void startTimer(BuildContext context, int currentlvl) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        timer.cancel();
        checkAnswer(currentlvl, context);
      } else {
        start--;
        emit(ChangeTimerState());
      }
    });
  }

  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;
  late SMITrigger confetti;
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

  void checkAnswer(int lvl, BuildContext context) {
    timer != null ? timer!.cancel() : null;
    emit(CheckanswerLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (itemselect == correct) {
          success.fire();
          Stringconstants.soundEffect
              ? effectsound.play(AssetSource(IMGManger.won))
              : null;
          Future.delayed(
            const Duration(seconds: 2),
            () {
              confetti.fire();
              Future.delayed(const Duration(seconds: 1), () {
                won(lvl, context);
              });
            },
          );
        } else {
          error.fire();
          Stringconstants.soundEffect
              ? effectsound.play(AssetSource(IMGManger.lost))
              : null;
          Future.delayed(
            const Duration(seconds: 2),
            () {
              reset.fire();
              lost(lvl, context);
              emit(CheckanswerError());
            },
          );
        }
      },
    );
  }

  void won(int lvl, BuildContext context) {
    int rate = start >= 40
        ? 3
        : start >= 20
            ? 2
            : 1;
    String time = (60 - start).toString();
    String status = 'won';
    database!.rawUpdate(
      'UPDATE level SET status = ?, rate = ?, time = ? WHERE level = ?',
      [status, rate, time, lvl],
    ).then((value) {
      lvl == lvls.length - 1 ? Navigator.pop(context) : null;
      database!.rawUpdate('UPDATE level SET status = ? WHERE level = ?',
          ['open', lvl + 1]).then((value) {
        AppRoutes.animremoves(context: context, screen: QuizScreen(lvl + 1));
      });
      CacheHelper.saveData(key: Stringconstants.currentlvl, value: lvl + 1);
      Stringconstants.currentlevel = lvl + 1;
    });
  }

  void lost(int lvl, BuildContext context) {
    int rate = 0;
    String time = (60 - start).toString();
    String status = 'lost';
    database!.rawUpdate(
      'UPDATE level SET status = ?, rate = ?, time = ? WHERE level = ?',
      [status, rate, time, lvl],
    ).then((value) {
      lvl == lvls.length - 1 ? Navigator.pop(context) : null;

      database!.rawUpdate('UPDATE level SET status = ? WHERE level = ?',
          ['open', lvl + 1]).then((value) {
        AppRoutes.animremoves(context: context, screen: QuizScreen(lvl + 1));
      });
      CacheHelper.saveData(key: Stringconstants.currentlvl, value: lvl + 1);
      Stringconstants.currentlevel = lvl + 1;
    });
  }

  double rating() {
    int rate = 0;
    int length = 0;
    for (var element in lvls) {
      double parsedRate = double.parse(element['rate'].toString());
      rate += parsedRate.round();
      if (element['status'] != 'close' && element['status'] != 'open') {
        length += 1;
      }
    }
    if (length == 0) {
      return 0;
    }
    double e = rate / length;
    String last = e.toStringAsPrecision(2);
    return double.parse(last);
  }

  void backgroundsound() {
    if (Stringconstants.backgroundSound) {
      Stringconstants.backgroundSound = false;
      CacheHelper.saveData(key: Stringconstants.backgrounds, value: false);
      audioPlayer.pause();
    } else {
      Stringconstants.backgroundSound = true;
      CacheHelper.saveData(key: Stringconstants.backgrounds, value: true);
      playsound(false);
    }
    emit(ChangeStateSound());
  }

  void soundeffect() {
    if (Stringconstants.soundEffect) {
      Stringconstants.soundEffect = false;
      CacheHelper.saveData(key: Stringconstants.sounde, value: false);
    } else {
      Stringconstants.soundEffect = true;
      CacheHelper.saveData(key: Stringconstants.sounde, value: true);
    }
    emit(ChangeStateSound());
  }
}
