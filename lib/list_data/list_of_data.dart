import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapi/list_data/bloc/list_state.dart';

import 'bloc/list_bloc.dart';

class ListOfData extends StatefulWidget {
  const ListOfData({super.key});

  @override
  State<ListOfData> createState() => _ListOfDataState();
}

class _ListOfDataState extends State<ListOfData> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body:
      
      BlocProvider(
        create: (context) {
          return ListBloc();
        },
        child:
        BlocBuilder<ListBloc,ListState>(
          builder: (context, state) {
            if(state is ListLoadingState){
              return CircularProgressIndicator();
            }
            if(state is ErrorState){
              return Text("Error ");
            }
      if(state is SuccessDataGet) {
        return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
      
              if (!state.hasReachedEnd &&
                  scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      
                context.read<ListBloc>().apiCalling();
              }
              return false;
            },
            child: ListView.builder(
                itemCount: state.hasReachedEnd
                ? state.posts.length
                : state.posts.length + 1,
              itemBuilder: (context, index) {
                if (index < state.posts.length) {
                  final post = state.posts[index];
                  return SizedBox(
                    height: 95,
                    child: Column(children: [
                      Text(post.id.toString()),
                      Text(post.title)
                    ],),
      
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
        },)
        );
      }
      return SizedBox();
          },
      
        ),
      ),),
    );
  }
}
