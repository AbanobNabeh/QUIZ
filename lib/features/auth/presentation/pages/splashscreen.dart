import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:iqchallenges/features/auth/presentation/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..initsplash(context),
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            extendBodyBehindAppBar: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(IMGManger.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: logoApp(),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
