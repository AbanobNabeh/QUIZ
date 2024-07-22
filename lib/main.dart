import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:iqchallenges/app.dart';
import 'package:iqchallenges/config/network/dioapp.dart';
import 'package:iqchallenges/config/shared%20preferences/shared_preferences.dart';
import 'package:iqchallenges/core/blocobserve/blocobserve.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'SET-API-KEY');
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioApp.init();
  runApp(const MyApp());
}
