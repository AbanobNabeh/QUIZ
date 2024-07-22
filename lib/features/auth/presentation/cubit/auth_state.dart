part of 'auth_cubit.dart';

abstract class AuthState {}

class HomeInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {}

/*
  final gemini = Gemini.instance;
      gemini
          .streamGenerateContent(
              'ترتيب الخيارات 1 2 3 4 مع الاجابه الصحيحه اعطيني سوال عن البرمجه مستوي 2 مع اربع اختيارات')
          .listen((value) {
        print(value.output);
      }).onError((e) {
        print('streamGenerateContent exception');
      });
 */