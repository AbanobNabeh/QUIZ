import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqchallenges/config/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iqchallenges/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:iqchallenges/features/auth/presentation/pages/splashscreen.dart';
import 'package:iqchallenges/features/quiz/presentation/cubit/quiz_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => QuizCubit()..playsound(true),
        )
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.dark,
            locale: Locale("ar"),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            darkTheme: AppTheme.darktheme(),
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
