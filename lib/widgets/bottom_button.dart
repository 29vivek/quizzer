import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  BottomButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            padding: EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(
                letterSpacing: 3.0,
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).accentColor,
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}