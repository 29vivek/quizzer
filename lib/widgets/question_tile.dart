import 'package:flutter/material.dart';
import 'package:quizzer/models/question_answer.dart';

class QuestionTile extends StatelessWidget {
  final QuestionAnswer qa;
  final int id;
  final Function callback;
  final bool hasFinishedAnswering;
  QuestionTile(this.qa, this.id, this.callback, this.hasFinishedAnswering);

  @override
  Widget build(BuildContext context) {
    List<Widget> radios = [];
    
    radios.add(ListTile(
      title: Text(QuestionAnswer.convertBase64ToString(qa.questions[id])),
    ));
    qa.allAnswers[id].forEach((var answer) {
      radios.add(Container(
        margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        color: hasFinishedAnswering ? answer == qa.correctAnswers[id] ? Colors.lightGreen.shade100 : Colors.red.shade100 : Colors.white,
        child: RadioListTile(
          value: answer,
          groupValue: qa.selectedAnswers[id],
          title: Text(QuestionAnswer.convertBase64ToString(answer)),
          onChanged: !hasFinishedAnswering ? (var newValue) {
            qa.selectedAnswers[id] = newValue;
            callback();
          } : null,
        ),
      ));
    });
    
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: radios,
      ),
    );
  }

}