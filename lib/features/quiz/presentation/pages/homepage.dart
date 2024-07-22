import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/core/utils/app_sring.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:iqchallenges/features/quiz/presentation/widgets/homewid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => QuizCubit.get(context).backgroundsound(),
                  icon: Icon(Stringconstants.backgroundSound
                      ? Icons.volume_up_outlined
                      : Icons.volume_off_outlined)),
              IconButton(
                  onPressed: () => QuizCubit.get(context).soundeffect(),
                  icon: Icon(Stringconstants.soundEffect
                      ? Icons.music_note_outlined
                      : Icons.music_off_outlined))
            ],
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IMGManger.background),
                fit: BoxFit.cover,
              ),
            ),
            child: state is GetLevelLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Center(child: profileCard(QuizCubit.get(context))),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemBuilder: (context, index) {
                                return lvlWid(
                                    index: index,
                                    lvl: QuizCubit.get(context).lvls[index + 1],
                                    context: context);
                              },
                              itemCount: QuizCubit.get(context).lvls.length - 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
