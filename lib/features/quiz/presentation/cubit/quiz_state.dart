part of 'quiz_cubit.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class GetLevelLoading extends QuizState {}

class GetLevelSuccess extends QuizState {}

class GetAskLoading extends QuizState {}

class GetAskSuccess extends QuizState {}

class SelectItemState extends QuizState {}

class ChangeTimerState extends QuizState {}

class CheckanswerLoading extends QuizState {}

class CheckanswerSuccess extends QuizState {}

class CheckanswerError extends QuizState {}

class ChangeStateSound extends QuizState {}
