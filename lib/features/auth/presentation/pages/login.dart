import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/core/components/app_components.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';
import 'package:iqchallenges/core/utils/assets_manger.dart';
import 'package:iqchallenges/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:iqchallenges/features/auth/presentation/widgets/loginwid.dart';
import 'package:iqchallenges/features/auth/presentation/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IMGManger.background),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  logoApp(),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Components.defText(text: "  مرحبا بك 👋"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(45))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                            child: loginWid(
                                cubit: AuthCubit.get(context),
                                state: state,
                                context: context)),
                      ),
                    ),
                  )
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
