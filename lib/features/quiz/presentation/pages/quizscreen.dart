import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/core/components/app_components.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/auth/presentation/widgets/loginwid.dart';
import 'package:iqchallenges/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:iqchallenges/features/quiz/presentation/widgets/quizwid.dart';
import 'package:rive/rive.dart';

class QuizScreen extends StatefulWidget {
  int lvl;
  QuizScreen(this.lvl, {super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizCubit? _quizCubit;

  @override
  void initState() {
    _quizCubit = QuizCubit.get(context);
    _quizCubit!.ask(context, widget.lvl);
    _quizCubit!.onCheckRiveInit;
    _quizCubit!.onConfettiRiveInit;
    super.initState();
  }

  @override
  void dispose() {
    if (_quizCubit?.timer != null) {
      _quizCubit!.timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      builder: (context, state) {
        QuizCubit cubit = QuizCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.purple140,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Components.defText(text: 'م.${widget.lvl}'),
                  ),
                ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IMGManger.background),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: state is GetAskLoading || state is GetLevelLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(45)),
                                  color: AppColors.purple,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(45)),
                                          color: AppColors.purple220,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Center(
                                              child: Components.defText(
                                                  text: cubit.asked,
                                                  textAlign: TextAlign.center,
                                                  size: 16),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: cubit.start <= 10
                                                        ? Colors.red
                                                        : AppColors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Components.defText(
                                                          text:
                                                              '00:${cubit.start < 10 ? '0${cubit.start}' : cubit.start}',
                                                          color:
                                                              AppColors.purple,
                                                          size: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      Icon(Icons.timer_outlined)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return answerWid(cubit.answer[index],
                                              cubit, index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox();
                                        },
                                        itemCount: cubit.answer.length),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Components.defButton(
                                            enable: cubit.itemselect != '',
                                            text: "تاكيد",
                                            onTap: () => cubit.checkAnswer(
                                                widget.lvl, context),
                                            width: MediaQuery.sizeOf(context)
                                                    .width /
                                                2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            state is CheckanswerLoading
                                ? CustomPositioned(
                                    child: RiveAnimation.asset(
                                      IMGManger.check,
                                      fit: BoxFit.cover,
                                      onInit: cubit.onCheckRiveInit,
                                    ),
                                  )
                                : const SizedBox(),
                            state is CheckanswerLoading
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
                        )),
                      ],
                    ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
