import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissbleList extends StatefulWidget {
  const DismissbleList({super.key});

  @override
  State<DismissbleList> createState() => _DismissbleListState();
}

class _DismissbleListState extends State<DismissbleList> {
  List<String> list = List.generate(2, (index) {
    return "Item $index";
  },);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
      return Dismissible(
        key: Key(list[index]),

        child: Container(height: 65,
          margin:EdgeInsets.fromLTRB(0, 4, 0, 2),
          width: MediaQuery.of(context).size.width,
        color: Color(0x93faff78),child: Text("data"),)
        ,direction: DismissDirection.endToStart,
        background: Container(color: Colors.red,),
      );
    },),));
  }
}
