import 'package:flutter/material.dart';
import 'package:free_fact/user_models/type.dart';

class TypeTiler extends StatelessWidget {

  final String types;
  final String type;
  final int colour;
  TypeTiler({required this.types, required this.type, required this.colour});

  @override
  Widget build(BuildContext context) {

    //Retrieves the colour based on the user's choice
    Color getColor() {
      Color color;
      if (colour == 1)
      {
        color = Colors.pinkAccent;
      }
      else
      {
        color = Colors.lightBlueAccent;
      }

      return color;
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: getColor(),
          ),
          title: Text(types),
          subtitle: Text(type),
        ),
      ),
    );
  }
}
