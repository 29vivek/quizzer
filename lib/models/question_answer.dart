import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz_model.dart';

class QuestionAnswer {
  Quiz quiz;
  QuestionAnswer();

  List all = [];
  int responseCode;
  int numberCorrect = 0;

  Map<int, dynamic> selectedAnswers = {};
  Map<int, List<dynamic>> allAnswers = {};
  Map<int, dynamic> correctAnswers = {};
  Map<int, dynamic> questions = {};
  Map<int, String> eachCategory= {};

  Map<String, List<int>> results = {};
  List<String> resultKeys = [];
  // each category to correctly answered, total

  static String convertBase64ToString(String base64EncodedString) =>
    String.fromCharCodes(base64.decode(base64EncodedString));

  Future<void> fetchQuestions() async {
    http.Response response = await http.get(quiz.generateURL());
    
    responseCode = jsonDecode(response.body)['response_code'];
    all = jsonDecode(response.body)['results'];

    all.forEach((var value) {
      int index = all.indexOf(value);
      correctAnswers[index] = value['correct_answer'];
      questions[index] = value['question'];

      eachCategory[index] = value['category'];

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

  void getResults() {
    eachCategory.forEach((int questionId, var value) {
      if(!results.keys.contains(value)) {
        results[value] = [0, 0];
      }
      if(selectedAnswers[questionId] ==correctAnswers[questionId]) {
        results[value][0]++;
        numberCorrect++;
      }
      
      results[value][1]++;

    });
    resultKeys =results.keys.toList();
  }
}