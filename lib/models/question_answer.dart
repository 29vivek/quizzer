import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionAnswer {

  List all = [];
  int responseCode;
  Map<int, dynamic> selectedAnswers = {};
  Map<int, List<dynamic>> allAnswers = {};
  Map<int, dynamic> correctAnswers = {};
  Map<int, dynamic> questions = {};

  static String convertBase64ToString(String base64EncodedString) =>
    String.fromCharCodes(base64.decode(base64EncodedString));

  Future<void> fetchQuestions(String url) async {
    http.Response response = await http.get(url);
    
    responseCode = jsonDecode(response.body)['response_code'];
    all = jsonDecode(response.body)['results'];

    all.forEach((var value) {
      int index = all.indexOf(value);
      correctAnswers[index] = value['correct_answer'];
      questions[index] = value['question'];
      if(convertBase64ToString(value['type']) == 'multiple') {
        allAnswers[index] = [value['correct_answer']] + value['incorrect_answers'];
        allAnswers[index].shuffle();
        // print(allAnswers[index]);
      }
      else {
        allAnswers[index] = [base64.encode('True'.codeUnits), base64.encode('False'.codeUnits)];
        // print(allAnswers[index]);
      } 
    });
  }
}