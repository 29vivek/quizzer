import 'package:http/http.dart' as http;
import 'dart:convert';

enum QuestionType { all, multiple, boolean }
enum Difficulty { all, easy, medium, hard }

class Quiz {
  
  int number;
  String category;
  Difficulty difficulty;
  QuestionType type;
  
  static const String categoryURL = 'https://opentdb.com/api_category.php';

  Map<int, String> categories = {};

  Quiz({this.number, this.category, this.difficulty, this.type});

  String generateURL() {
    String url = 'https://opentdb.com/api.php?amount=$number';
    if(category != 'All') {
      url += '&category=${categories.keys.firstWhere((int key) => categories[key] == category, orElse: () => null)}';
    }
    if(difficulty != Difficulty.all) {
      url += '&difficulty=${difficulty.toString().split('.').last}';
    } 
    if(type !=QuestionType.all) {
      url += '&type=${type.toString().split('.').last}';
    }
    url += '&encode=base64';
    return url;
  }

  Future<void> getCategories() async {
    http.Response response = await http.get(categoryURL);
    
    List list = jsonDecode(response.body)['trivia_categories'];
    categories[0] = category;
    list.forEach((ele) {
      categories[ele['id']] = ele['name'];
    });
  } 

}