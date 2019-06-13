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
    _questionAnswer.quiz = widget.quiz;
    getQuestions();
    super.initState();
  }

  void getQuestions() async {
    _isLoading = true;
    await _questionAnswer.fetchQuestions();
    
    if(this.mounted) {
      setState(() {
        _isLoading = false;  
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quizzer'),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Questions',),
              Tab(text: !_isFinished ? 'Results' : 'Results (${_questionAnswer.numberCorrect}/${_questionAnswer.quiz.number})'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
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
                    itemCount: _questionAnswer.quiz.number,
                    itemBuilder: (context, int id) {
                      return QuestionTile(_questionAnswer, id, () {
                        setState(() {});
                      }, _isFinished);
                    },
                  ),
                ),
                BottomButton(
                  text: !_isFinished && _questionAnswer.responseCode == 0 ? 'FINISH QUIZ' : 'GO BACK',
                  onTap: () {
                    !_isFinished && _questionAnswer.responseCode == 0 ? setState(() {
                        _isFinished = true;
                        _questionAnswer.getResults();
                      }) : 
                      Navigator.pop(context);
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                !_isFinished ?
                Expanded(
                  child: Center(
                    child: ListTile( 
                      title: Text('You haven\'t completed the quiz'),
                      subtitle: Text('Finish the quiz first to view the results.'),
                    ),
                  ),
                ):
                Expanded(
                  child: ListView.builder(
                    itemCount: _questionAnswer.results.length,
                    itemBuilder: (BuildContext context, int id) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text('Category: ${QuestionAnswer.convertBase64ToString(_questionAnswer.resultKeys[id])}'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                              child: Text('Correctly Answered: ${_questionAnswer.results[_questionAnswer.resultKeys[id]][0]}'),
                            ),
                            Padding(
                              padding:EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                              child: Text('Total Questions: ${_questionAnswer.results[_questionAnswer.resultKeys[id]][1]}'),
                            ), 
                          ],
                        ),
                      );
                    },
                  ),
                ),
                BottomButton(
                  text: 'GO BACK',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ) 
        
        
      ),
    );
  }
}