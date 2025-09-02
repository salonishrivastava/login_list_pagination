import 'dart:math';
import 'package:flutter/material.dart';




class AnimatedListExample extends StatefulWidget {
  const AnimatedListExample({super.key});

  @override
  State createState() => MyStateClass();
}

class MyStateClass extends State{
  final GlobalKey<AnimatedListState> _listOfKey = GlobalKey<AnimatedListState>();
  List<Color> _listOfColors=[];

  Color generateRandomColors(){
    Random r=Random();
    return Color.fromARGB(
        255,r.nextInt(256),
        r.nextInt(256),
        r.nextInt(256));
  }

  void _removeItem(int index) {
    final removedColor = _listOfColors.removeAt(index);
    _listOfKey.currentState!.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 80,
          color: removedColor,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
      ),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context){

    return Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () {
          print("ClicKK ${_listOfColors.length}");
          var len =_listOfColors.length;
          _listOfColors.insert(_listOfColors.length,generateRandomColors());

          _listOfKey.currentState!.insertItem(len,duration:Duration(milliseconds: 1000));

          setState(() {

          });

        },),
        body: AnimatedList(key: _listOfKey,initialItemCount: _listOfColors.length,
          itemBuilder: (context, index, animation) {
            return SizeTransition(child: Container(
                color: _listOfColors[index],
                height:45,
                margin:EdgeInsets.all(1)

            ),sizeFactor: animation,);

          },)
    )
    ;
  }
}