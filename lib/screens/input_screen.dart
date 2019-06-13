import 'package:flutter/material.dart';
import 'package:quizzer/models/quiz_model.dart';
import 'package:quizzer/screens/quiz_screen.dart';
import 'package:quizzer/widgets/bottom_button.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() {
    return InputScreenState();
  }

}

class InputScreenState extends State<InputScreen> {
  
  Quiz quiz = Quiz(number: 10, category: 'All', difficulty: Difficulty.all, type: QuestionType.all);

  @override
  void initState() {

    getCategories();
    super.initState();
  }

  void getCategories() async {
    await quiz.getCategories();
    setState(() {
      quiz.category = quiz.categories[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzer'),
      ),
      body: Column(
        children: <Widget>[ 
          Expanded(
            child: ListView(
              children: <Widget>[
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text('Number of Questions'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '${quiz.number}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 6.0, bottom: 16.0, left: 6.0),
                        child: Slider(
                          value: quiz.number.toDouble(),
                          min: 10,
                          max: 50,
                          onChanged: (double value) {
                            setState(() {
                              quiz.number = value.floor();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('Category'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 32.0, left: 24.0, bottom: 16.0), 
                        child: quiz.categories.length == 0 ? 
                          LinearProgressIndicator() :
                          DropdownButton(
                            isExpanded: true,
                            value: quiz.category,
                            items: quiz.categories.values.toList()
                              .map<DropdownMenuItem<String>>((String category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }
                            ).toList(),
                            onChanged: (String newCategory) {
                              setState(() {
                                quiz.category = newCategory;
                              });
                            },
                          ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('Difficulty'),
                      ),
                      RadioListTile(
                        title: Text('All'),
                        value: Difficulty.all,
                        groupValue: quiz.difficulty,
                        onChanged: (Difficulty value) {
                          setState(() {
                            quiz.difficulty = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Easy'),
                        value: Difficulty.easy,
                        groupValue: quiz.difficulty,
                        onChanged: (Difficulty value) {
                          setState(() {
                            quiz.difficulty = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Medium'),
                        value: Difficulty.medium,
                        groupValue: quiz.difficulty,
                        onChanged: (Difficulty value) {
                          setState(() {
                            quiz.difficulty = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Hard'),
                        value: Difficulty.hard,
                        groupValue: quiz.difficulty,
                        onChanged: (Difficulty value) {
                          setState(() {
                            quiz.difficulty = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('Question Type'),
                      ),
                      RadioListTile(
                        title: Text('All'),
                        value: QuestionType.all,
                        groupValue: quiz.type,
                        onChanged: (QuestionType value) {
                          setState(() {
                            quiz.type = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Multiple Choice'),
                        value: QuestionType.multiple,
                        groupValue: quiz.type,
                        onChanged: (QuestionType value) {
                          setState(() {
                            quiz.type = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('True/ False'),
                        value:QuestionType.boolean,
                        groupValue: quiz.type,
                        onChanged: (QuestionType value) {
                          setState(() {
                            quiz.type = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            text: 'START QUIZ',
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  maintainState: false,
                  builder:  (BuildContext context) => QuizScreen(quiz),
                ),
              );
            },
          ),
        ],  
      ),
      
    );
  }

} 
