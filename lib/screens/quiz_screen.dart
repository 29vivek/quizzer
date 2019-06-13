import 'package:flutter/material.dart';
import 'package:quizzer/models/question_answer.dart';
import 'package:quizzer/models/quiz_model.dart';
import 'package:quizzer/widgets/bottom_button.dart';
import 'package:quizzer/widgets/question_tile.dart';
class QuizScreen extends StatefulWidget {

  final Quiz quiz;
  QuizScreen(this.quiz);
  
  @override
  State<QuizScreen> createState() {
    return QuizScreenState();
  }
  
}

class QuizScreenState extends State<QuizScreen> {
  
  QuestionAnswer _questionAnswer = QuestionAnswer();
  bool _isFinished = false;
  bool _isLoading = true;

  @override
  void initState() {
    getQuestions();
    super.initState();
  }

  void getQuestions() async {
    print(widget.quiz);
    _isLoading = true;
    await _questionAnswer.fetchQuestions(widget.quiz.generateURL());
    
    if(this.mounted) {
      setState(() {
        _isLoading = false;  
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _isLoading ?
          Expanded(
            child: Center(
              child: CircularProgressIndicator(value: 5.0,),
            ),
          ):
          _questionAnswer.responseCode != 0 ? 
          Expanded(
            child: Center(
              child: ListTile(
                title:Text('Error has occured.'),
                subtitle: Text('There isn\'t suffiecient amount of questions which meet your criteria.'),
              ),
            ),
          ):
          Expanded(
            child: ListView.builder(
              itemCount: _questionAnswer.questions.length,
              itemBuilder: (context, int id) {
                return QuestionTile(_questionAnswer, id, () {
                  setState(() {});
                }, _isFinished);
              },
            ),
          ),
          BottomButton(
            text: !_isFinished && _questionAnswer.responseCode == 0 ? 'CHECK ANSWERS' : 'GO BACK',
            onTap: () {
              !_isFinished && _questionAnswer.responseCode == 0 ? setState(() {
                  _isFinished = true;
                }) : 
                Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}