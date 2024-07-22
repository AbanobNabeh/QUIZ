import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:iqchallenges/core/utils/app_sring.dart';

class DioApp {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://generativelanguage.googleapis.com/v1beta/',
        receiveDataWhenStatusError: true,
        headers: {"Accept": "application/json"},
      ),
    );
  }

  static Map<String, String> extractOptions(String questionText) {
    // Example implementation, customize based on your needs
    return {
      'option1': 'Option 1',
      'option2': 'Option 2',
      'option3': 'Option 3',
      'option4': 'Option 4',
      'correct': 'Correct Answer',
    };
  }

  static Future<Map<String, dynamic>?> postData({
    required int level,
  }) async {
    try {
      final response = await dio.post(
        'models/gemini-1.5-flash:generateContent?key=AIzaSyBOo1xvH2V8Ot6JsabeAUohAl-V9-vCMZI',
        data: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      'هل يمكنني اعطي سوال عن ${Stringconstants.interestedin} مستوي $level في شكل Map يكون مرتب مثلا {"ask" : هنا يكون السوال, "answer" : [تكون الاجابات], "correct": ويبدا من 1 وليس 0 اعطيني رقم الاجابه الصحيحه} بدون اي اضافه اريد map فقط'
                }
              ]
            }
          ]
        }),
      );
      var data = response.data['candidates'][0]['content']['parts'][0]['text'];
      RegExp regex = RegExp(r'\{(.*?)\}', dotAll: true);
      Match? match = regex.firstMatch(data);
      if (match != null) {
        String jsonText = match.group(0)!;
        try {
          Map<String, dynamic> jsonData = jsonDecode(jsonText);
          print(jsonData);
          return {
            'ask': jsonData['ask'],
            'answer': jsonData['answer'],
            'correct': jsonData['correct'],
          };
        } catch (e) {
          throw Exception(
              'Failed to generate question: ${response.statusCode}');
        }
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
